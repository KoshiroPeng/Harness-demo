---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 治理文档总览

## 目标

本目录沉淀 HernessDemo 的发布审批、权限和审计治理规则，帮助协作者明确谁可以做什么、发布前后需要满足哪些治理要求。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 发布治理 | [docs/governance/release-governance.md](release-governance.md) |

## 使用建议

- 做发布方案设计时，应同步确认审批链路、操作权限和审计要求。
- 做交付流程调整时，应把治理规则视为强约束，而不是事后补充说明。
- 做需求评审时，若需求涉及敏感操作、权限边界或审计要求，应同步参考本目录。

## 维护规则

- 新增审批、权限或审计规则后，必须同步更新本文档。
- 若治理规则影响交付主路径，还必须同步更新 [docs/README.md](../README.md) 和 [docs/delivery/delivery-operations-map.md](../delivery/delivery-operations-map.md)。
