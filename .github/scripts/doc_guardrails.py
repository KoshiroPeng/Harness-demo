#!/usr/bin/env python3
"""HarnessBase 文档与 workflow 护栏检查脚本。

当前阶段只实现：
- A01：治理型 Markdown 元数据标头检查
- A02：Markdown 相对链接与锚点检查
- A03：已删除文档引用检查（并入 A02）
- A04：历史事实误用扫描（提醒模式）
- A05：workflow 路径存在性检查
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
WORKFLOW_GLOB = ".github/workflows/*.yml"
HISTORY_FACT_TERMS = (
    "RuoYi-Vue-Plus",
    "ruoyi-admin",
    "ruoyi-extend",
    "org.dromara",
    "server/script/sql",
    "ProjectPilot",
    "CallCenter",
    "services/callcenter-server",
    "Spring Boot 3",
    "Vue 3",
    "Vite",
    "Pinia",
    "TypeScript",
    "pnpm",
)
HISTORY_CONTEXT_ALLOWLIST = (
    "历史",
    "旧",
    "过期",
    "误用",
    "纠偏",
    "禁止",
    "不应",
    "不再",
    "不是",
    "不存在",
    "当前不存在",
    "后续若引入",
    "条件性",
    "命中词",
    "扫描对象",
    "高风险命中词",
)
GENERATED_PATH_PREFIXES = (
    "artifacts",
    "release-output",
    "release-bundle",
    "server/${{",
    "web/dist",
)
GENERATED_PATH_PARTS = {"target", "dist", "artifacts", "release-output", "release-bundle"}


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


def is_history_scan_markdown(path: Path) -> bool:
    rel = repo_rel(path)

    if rel in {"AGENTS.md", "README.md", ".github/README.md", "server/README.md", "web/README.md"}:
        return True

    return rel.startswith("docs/") or rel.startswith("deploy/")


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


def term_pattern(term: str) -> re.Pattern[str]:
    return re.compile(rf"(?<![A-Za-z0-9_.-]){re.escape(term)}(?![A-Za-z0-9_.-])")


def is_allowed_history_context(lines: list[str], line_index: int) -> bool:
    context_start = max(0, line_index - 12)
    context_lines = lines[context_start : min(len(lines), line_index + 2)]
    context = " ".join(context_lines)
    return any(keyword in context for keyword in HISTORY_CONTEXT_ALLOWLIST)


def check_history_fact_terms() -> list[Finding]:
    findings: list[Finding] = []
    rule = "docs/conventions/automation-check-catalog.md"
    patterns = [(term, term_pattern(term)) for term in HISTORY_FACT_TERMS]

    for path in iter_markdown_files():
        if not is_history_scan_markdown(path):
            continue

        lines = read_text(path).splitlines()
        for line_index, line in enumerate(lines):
            for term, pattern in patterns:
                if not pattern.search(line):
                    continue

                if is_allowed_history_context(lines, line_index):
                    continue

                findings.append(
                    Finding(
                        check_id="A04",
                        level="提醒",
                        path=repo_rel(path),
                        problem=f"第 {line_index + 1} 行疑似历史事实误用: {term}",
                        rule=rule,
                        suggestion="人工复核该词是否属于当前事实；若是纠偏语境，请补充明确的历史、误用或禁止说明",
                    )
                )

    return findings


def iter_workflow_files() -> Iterable[Path]:
    return sorted(ROOT.glob(WORKFLOW_GLOB))


def strip_yaml_value(value: str) -> str:
    value = value.strip()
    if not value:
        return value
    if value[0] in {'"', "'"} and value[-1:] == value[0]:
        return value[1:-1].strip()
    return value


def is_dynamic_or_generated_path(path_value: str) -> bool:
    if not path_value:
        return True

    if "://" in path_value:
        return True

    if path_value.startswith(("/", "~", "$")):
        return True

    if "${{" in path_value or "${" in path_value:
        return True

    normalized = path_value.strip()
    return any(
        normalized == prefix or normalized.startswith(f"{prefix}/") or normalized.startswith(prefix)
        for prefix in GENERATED_PATH_PREFIXES
    )


def static_prefix_before_glob(path_value: str) -> str:
    parts = path_value.split("/")
    static_parts: list[str] = []
    for part in parts:
        if not part or part in GENERATED_PATH_PARTS or any(token in part for token in ("*", "?", "[")):
            break
        static_parts.append(part)
    return "/".join(static_parts)


def workflow_path_exists(path_value: str) -> bool:
    if is_dynamic_or_generated_path(path_value):
        return True

    candidate = static_prefix_before_glob(path_value) if any(token in path_value for token in "*?[") else path_value
    if not candidate:
        return True

    return (ROOT / candidate).exists()


def append_workflow_path_finding(
    findings: list[Finding],
    workflow_path: Path,
    line_number: int,
    field: str,
    path_value: str,
) -> None:
    findings.append(
        Finding(
            check_id="A05",
            level="阻断",
            path=repo_rel(workflow_path),
            problem=f"第 {line_number} 行 `{field}` 引用的路径不存在: {path_value}",
            rule="docs/conventions/automation-check-catalog.md",
            suggestion="修正 workflow 路径，或先补齐被引用的脚本、目录、模板或依赖文件",
        )
    )


def check_workflow_scalar_path_fields(path: Path, lines: list[str]) -> list[Finding]:
    findings: list[Finding] = []
    scalar_pattern = re.compile(r"^\s*(working-directory|cache-dependency-path|path):\s*(.+?)\s*$")

    for line_number, line in enumerate(lines, 1):
        match = scalar_pattern.match(line)
        if not match:
            continue

        field = match.group(1)
        path_value = strip_yaml_value(match.group(2))
        if path_value == "|":
            continue
        if not workflow_path_exists(path_value):
            append_workflow_path_finding(findings, path, line_number, field, path_value)

    return findings


def check_workflow_block_path_fields(path: Path, lines: list[str]) -> list[Finding]:
    findings: list[Finding] = []
    block_start_pattern = re.compile(r"^(\s*)(path):\s*\|\s*$")
    item_pattern = re.compile(r"^\s+(.+?)\s*$")

    for line_index, line in enumerate(lines):
        start_match = block_start_pattern.match(line)
        if not start_match:
            continue

        base_indent = len(start_match.group(1))
        field = start_match.group(2)

        for child_index in range(line_index + 1, len(lines)):
            child_line = lines[child_index]
            if not child_line.strip():
                continue

            indent = len(child_line) - len(child_line.lstrip(" "))
            if indent <= base_indent:
                break

            item_match = item_pattern.match(child_line)
            if not item_match:
                continue

            path_value = strip_yaml_value(item_match.group(1))
            if not workflow_path_exists(path_value):
                append_workflow_path_finding(findings, path, child_index + 1, field, path_value)

    return findings


def check_workflow_run_paths(path: Path, lines: list[str]) -> list[Finding]:
    findings: list[Finding] = []
    command_pattern = re.compile(r"\b(?:bash|cat|chmod\s+\+x)\s+([A-Za-z0-9_./${}*?\\-]+)")

    for line_number, line in enumerate(lines, 1):
        for match in command_pattern.finditer(line):
            path_value = strip_yaml_value(match.group(1))
            if not workflow_path_exists(path_value):
                append_workflow_path_finding(findings, path, line_number, "run", path_value)

    return findings


def check_workflow_paths() -> list[Finding]:
    findings: list[Finding] = []

    for path in iter_workflow_files():
        lines = read_text(path).splitlines()
        findings.extend(check_workflow_scalar_path_fields(path, lines))
        findings.extend(check_workflow_block_path_fields(path, lines))
        findings.extend(check_workflow_run_paths(path, lines))

    return findings


def print_summary(findings: list[Finding]) -> None:
    blockers = [finding for finding in findings if finding.level == "阻断"]
    reminders = [finding for finding in findings if finding.level == "提醒"]

    if not blockers and not reminders:
        print("[A01/A02/A03/A04/A05][通过] 文档与 workflow 护栏检查通过")
        print("说明: 治理型 Markdown 标头、相对链接、锚点、历史事实误用扫描和 workflow 路径检查均未发现问题")
        return

    grouped: dict[str, list[Finding]] = {}
    for finding in blockers:
        grouped.setdefault(finding.check_id, []).append(finding)

    for check_id in ("A01", "A02", "A05"):
        items = grouped.get(check_id, [])
        if not items:
            continue

        titles = {
            "A01": "治理型 Markdown 元数据标头检查未通过",
            "A02": "Markdown 相对链接与锚点检查未通过",
            "A05": "workflow 路径存在性检查未通过",
        }
        title = titles[check_id]

        print(f"[{check_id}][阻断] {title}")
        for index, item in enumerate(items, 1):
            print(f"{index}. 文件: {item.path}")
            print(f"   问题: {item.problem}")
        print(f"规则: {items[0].rule}")
        print(f"建议: {items[0].suggestion}")
        print()

    if reminders:
        print("[A04][提醒] 历史事实误用扫描发现需要人工复核的命中项")
        for index, item in enumerate(reminders, 1):
            print(f"{index}. 文件: {item.path}")
            print(f"   问题: {item.problem}")
        print(f"规则: {reminders[0].rule}")
        print(f"建议: {reminders[0].suggestion}")
        print()

    if not blockers:
        print("[A01/A02/A03/A04/A05][通过] 未发现阻断问题")
        print("说明: A04 当前为提醒模式，命中项只提示人工复核，不阻断主线")


def main() -> int:
    findings: list[Finding] = []
    findings.extend(check_frontmatter())
    findings.extend(check_links())
    findings.extend(check_history_fact_terms())
    findings.extend(check_workflow_paths())
    print_summary(findings)
    return 1 if any(finding.level == "阻断" for finding in findings) else 0


if __name__ == "__main__":
    sys.exit(main())
