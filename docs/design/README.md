---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 设计文档总览

## 目标

本目录沉淀 HernessDemo 的功能设计文档，帮助需求评审、详细设计评审和开发实现快速找到对应业务方向的设计材料。

## 推荐入口

如果你现在是做需求评审，优先阅读：

- [docs/reviews/requirement-review-checklist.md](../reviews/requirement-review-checklist.md)

如果你现在是按任务查找整组文档，优先阅读：

- [docs/README.md](../README.md)

## 文档索引

| 业务方向 | 文档 |
| --- | --- |
| 认证与权限 | [docs/design/feature-auth.md](feature-auth.md) |
| 搜索 | [docs/design/feature-search.md](feature-search.md) |
| 计费 | [docs/design/feature-billing.md](feature-billing.md) |

## 使用建议

- 新功能若已有相近业务方向，应先复用或扩展现有设计文档，而不是另起一套术语。
- 若设计会影响 API、错误码、交付流程或运行手册，应同步更新对应目录文档。
- 若当前设计还处于草稿阶段，也应先在本目录落一个最小设计说明，避免信息只停留在对话中。

## 维护规则

- 新增功能方向时，在本目录增加对应设计文档，并同步更新本文档。
- 若目录中文档已废弃或被替代，应在本文档中标明当前推荐入口。
