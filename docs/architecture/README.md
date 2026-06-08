---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 架构文档目录入口，汇总代码地图、技术基线、模块边界、数据流与 Harness 护栏。
---

# 架构文档总览

## 目标

本目录沉淀 HernessDemo 的真实代码地图、技术基线、模块边界、数据流与 Harness Engineering 护栏。架构文档必须解释当前 RuoYi-Vue-Plus 工程，而不是延续 ProjectPilot、CallCenter 或其他过渡设想。

## 推荐阅读顺序

1. [docs/architecture/code-map.md](code-map.md)
2. [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)
3. [docs/architecture/overview.md](overview.md)
4. [docs/architecture/boundaries.md](boundaries.md)
5. [docs/architecture/data-flow.md](data-flow.md)
6. [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md)

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 当前代码地图 | [docs/architecture/code-map.md](code-map.md) |
| 技术基线 | [docs/architecture/target-technology-baseline.md](target-technology-baseline.md) |
| 系统架构总览 | [docs/architecture/overview.md](overview.md) |
| 模块边界与依赖约束 | [docs/architecture/boundaries.md](boundaries.md) |
| 数据流与关键链路 | [docs/architecture/data-flow.md](data-flow.md) |
| Harness Engineering 落地说明 | [docs/architecture/harness-engineering-adaptation.md](harness-engineering-adaptation.md) |

## 维护原则

- 架构结论必须能回到 [docs/architecture/code-map.md](code-map.md) 或真实代码验证。
- 新增模块、删除模块、移动目录、调整 workflow 或发布入口时，优先更新代码地图和本索引。
- 如果发现文档还在引用 `ProjectPilot`、`CallCenter` 或 `services/callcenter-server` 作为当前事实，应立即收敛。
