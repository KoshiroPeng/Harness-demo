---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 交付文档总览

## 目标

本目录沉淀 HernessDemo 的交付模型、环境治理、流水线、部署策略和制品治理规则，帮助开发、测试和运维在发布相关任务中快速找到正确文档。

## 推荐入口

如果你现在是按任务查找文档，优先阅读：

- [docs/README.md](../README.md)

如果你现在是做发布、回滚、环境初始化或交付排障，优先阅读：

- [docs/delivery/delivery-operations-map.md](delivery-operations-map.md)

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 交付总览与任务入口 | [docs/delivery/delivery-operations-map.md](delivery-operations-map.md) |
| 交付模型 | [docs/delivery/delivery-model.md](delivery-model.md) |
| 环境治理 | [docs/delivery/environments.md](environments.md) |
| GitHub Environment 映射 | [docs/delivery/github-environments.md](github-environments.md) |
| 流水线设计 | [docs/delivery/pipelines.md](pipelines.md) |
| 部署策略 | [docs/delivery/deployment-strategies.md](deployment-strategies.md) |
| 制品治理 | [docs/delivery/artifact-policy.md](artifact-policy.md) |
| 功能开关 | [docs/delivery/feature-flags.md](feature-flags.md) |

## 使用建议

- 做需求或设计评审时，若涉及发布、回滚、环境或制品策略，应同步参考本目录。
- 做开发时，若改动会影响部署方式、环境变量、发布步骤或回滚路径，应同步更新本目录文档。
- 做测试时，若需要验证发布后行为，应与 [docs/operations/release-verification.md](../operations/release-verification.md) 联动阅读。

## 维护规则

- 新增交付相关文档后，必须同步更新本文档。
- 若新增文档会影响开发、测试、评审或交付主路径，还必须同步更新 [docs/README.md](../README.md)。
