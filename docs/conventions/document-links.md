---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 文档链接规范，统一约束相对链接、绝对路径和导航文档中的链接写法。
---

# 文档链接规范

## 目标

本文档用于统一 HernessDemo 仓库中文档路径的写法，提升人类读者与 AI 协作者的可导航性、可理解性和维护体验。

## 基本原则

- 导航型文档优先使用 Markdown 链接。
- 正文描述中的普通目录说明可以使用纯文本路径。
- 关键入口、关键 workflow、关键脚本和关键运行手册必须使用可点击链接。

## 适用范围

以下文档应优先使用 Markdown 链接：

- `README.md`
- `AGENTS.md`
- 各类总览页、索引页、导航页
- 各目录下的 `README.md` 或等价索引页
- 发布与回滚手册
- 运行手册

以下场景允许使用纯文本路径：

- 解释目录结构时的简短说明
- 代码块中的示例路径
- 非关键上下文中的一次性目录提及

## 推荐写法

### 导航入口

推荐：

- `[docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)`
- `[deploy/release/README.md](../../deploy/release/README.md)`

不推荐：

- `` `docs/design/backend-admin-roadmap.md` ``
- `` `deploy/release/README.md` ``

### 关键 workflow

推荐：

- `[.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)`

### 关键脚本

推荐：

- `[deploy/release/deploy-via-ssh.sh](../../deploy/release/deploy-via-ssh.sh)`

## AI 协作建议

从 AI 协作角度看：

- 纯文本路径通常也能被理解。
- Markdown 链接额外提供了语义标签和可点击入口。
- 对于需要频繁跳转的文档，链接化能显著降低定位成本。

因此建议：

- 索引型内容一律链接化。
- 目录型内容尽量有一个明确的索引页，不要只暴露裸目录。
- 描述型内容按可读性决定是否保留纯文本路径。

## 维护规则

- 新增导航表、索引表时，默认使用 Markdown 链接。
- 已有文档若承担“统一入口”职责，应逐步把纯文本路径替换为链接。
