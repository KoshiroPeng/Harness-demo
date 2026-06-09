#!/usr/bin/env python3
"""HarnessBase 文档护栏检查脚本。

当前阶段只实现：
- A01：治理型 Markdown 元数据标头检查
- A02：Markdown 相对链接与锚点检查
- A03：已删除文档引用检查（并入 A02）
"""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parent.parent.parent
REQUIRED_FRONTMATTER_KEYS = ("last_updated", "status", "owner", "description")
MARKDOWN_EXTENSIONS = {".md", ".markdown"}
IGNORED_DIR_NAMES = {"node_modules", ".git", "target", "dist", ".idea"}


@dataclass(frozen=True)
class Finding:
    check_id: str
    level: str
    path: str
    problem: str
    rule: str
    suggestion: str


def repo_rel(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def iter_markdown_files() -> Iterable[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*.md"):
        if not path.is_file():
            continue
        if any(part in IGNORED_DIR_NAMES for part in path.relative_to(ROOT).parts):
            continue
        files.append(path)
    return sorted(files)


def is_governance_markdown(path: Path) -> bool:
    rel = repo_rel(path)

    if rel == "README.md":
        return False

    if rel == "server/.gitee/PULL_REQUEST_TEMPLATE.zh-CN.md":
        return False

    if rel == "server/script/docker/redis/data/README.md":
        return False

    if path.name == "package-info.md":
        return False

    if rel == "AGENTS.md":
        return True

    if rel.startswith("docs/") or rel.startswith("deploy/"):
        return True

    if rel in {".github/README.md", "server/README.md", "web/README.md"}:
        return True

    return False


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def parse_frontmatter(lines: list[str]) -> tuple[dict[str, str] | None, str | None]:
    if not lines or lines[0].strip() != "---":
        return None, "文件头部缺少 `---` 标头起始行"

    end_index = None
    for idx in range(1, len(lines)):
        if lines[idx].strip() == "---":
            end_index = idx
            break

    if end_index is None:
        return None, "元数据标头缺少结束行 `---`"

    data: dict[str, str] = {}
    for line in lines[1:end_index]:
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        data[key.strip()] = value.strip()
    return data, None


def slugify_heading(text: str) -> str:
    text = re.sub(r"`([^`]+)`", r"\1", text.strip()).lower()
    text = re.sub(r"\s+", "-", text)
    text = re.sub(r"[^\w\-\u4e00-\u9fff]", "", text)
    return text


def collect_headings(text: str) -> set[str]:
    headings: set[str] = set()
    for line in text.splitlines():
        match = re.match(r"^(#{1,6})\s+(.*)$", line)
        if match:
            headings.add(slugify_heading(match.group(2)))
    return headings


def check_frontmatter() -> list[Finding]:
    findings: list[Finding] = []
    rule = "docs/conventions/document-metadata.md"

    for path in iter_markdown_files():
        if not is_governance_markdown(path):
            continue

        lines = read_text(path).splitlines()
        frontmatter, error = parse_frontmatter(lines)
        if error:
            findings.append(
                Finding(
                    check_id="A01",
                    level="阻断",
                    path=repo_rel(path),
                    problem=error,
                    rule=rule,
                    suggestion="补齐统一元数据标头后重新执行检查",
                )
            )
            continue

        missing_keys = [key for key in REQUIRED_FRONTMATTER_KEYS if key not in frontmatter]
        if missing_keys:
            findings.append(
                Finding(
                    check_id="A01",
                    level="阻断",
                    path=repo_rel(path),
                    problem=f"缺少标头字段: {', '.join(missing_keys)}",
                    rule=rule,
                    suggestion="补齐缺失字段并同步更新 `last_updated`",
                )
            )

    return findings


def check_links() -> list[Finding]:
    findings: list[Finding] = []
    rule = "docs/conventions/document-links.md"
    markdown_link_pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
    headings_cache: dict[Path, set[str]] = {}

    for path in iter_markdown_files():
        text = read_text(path)
        self_headings = headings_cache.setdefault(path, collect_headings(text))

        for line_number, line in enumerate(text.splitlines(), 1):
            for match in markdown_link_pattern.finditer(line):
                target = match.group(1).strip()

                if not target:
                    continue

                if "://" in target or target.startswith("mailto:"):
                    continue

                if target.startswith("#"):
                    anchor = slugify_heading(unquote(target[1:]))
                    if anchor and anchor not in self_headings:
                        findings.append(
                            Finding(
                                check_id="A02",
                                level="阻断",
                                path=repo_rel(path),
                                problem=f"第 {line_number} 行缺少页内锚点: {target}",
                                rule=rule,
                                suggestion="修正文档标题或更新页内链接锚点",
                            )
                        )
                    continue

                target_path_raw, _, anchor_raw = target.partition("#")
                resolved = (path.parent / target_path_raw).resolve()

                if not resolved.exists():
                    findings.append(
                        Finding(
                            check_id="A02",
                            level="阻断",
                            path=repo_rel(path),
                            problem=f"第 {line_number} 行缺少相对链接目标: {target}",
                            rule=rule,
                            suggestion="修正相对路径或删除失效引用",
                        )
                    )
                    continue

                if not anchor_raw or resolved.suffix.lower() not in MARKDOWN_EXTENSIONS:
                    continue

                target_headings = headings_cache.get(resolved)
                if target_headings is None:
                    target_headings = collect_headings(read_text(resolved))
                    headings_cache[resolved] = target_headings

                anchor = slugify_heading(unquote(anchor_raw))
                if anchor and anchor not in target_headings:
                    findings.append(
                        Finding(
                            check_id="A02",
                            level="阻断",
                            path=repo_rel(path),
                            problem=f"第 {line_number} 行缺少目标锚点: {target}",
                            rule=rule,
                            suggestion="修正目标文档标题或更新链接锚点",
                        )
                    )

    return findings


def print_summary(findings: list[Finding]) -> None:
    if not findings:
        print("[A01/A02/A03][通过] 文档护栏检查通过")
        print("说明: 治理型 Markdown 标头、相对链接和锚点检查均未发现问题")
        return

    grouped: dict[str, list[Finding]] = {}
    for finding in findings:
        grouped.setdefault(finding.check_id, []).append(finding)

    for check_id in ("A01", "A02"):
        items = grouped.get(check_id, [])
        if not items:
            continue

        title = (
            "治理型 Markdown 元数据标头检查未通过"
            if check_id == "A01"
            else "Markdown 相对链接与锚点检查未通过"
        )

        print(f"[{check_id}][阻断] {title}")
        for index, item in enumerate(items, 1):
            print(f"{index}. 文件: {item.path}")
            print(f"   问题: {item.problem}")
        print(f"规则: {items[0].rule}")
        print(f"建议: {items[0].suggestion}")
        print()


def main() -> int:
    findings: list[Finding] = []
    findings.extend(check_frontmatter())
    findings.extend(check_links())
    print_summary(findings)
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
