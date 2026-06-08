---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 当前迭代计划，聚焦文档代码对齐、历史残留清理、workflow 路径修正与 Harness 护栏落地。
---

# 当前迭代计划

## 迭代目标

把 HernessDemo 从“重构后文档与代码大量不一致”的状态，收敛为“代码地图清楚、文档入口可信、发布路径可核对、Harness 护栏可执行”的状态。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 将文档主线对齐当前 RuoYi-Vue-Plus 代码事实 | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/overview.md](../architecture/overview.md) |
| P0 | 清理 ProjectPilot、CallCenter、Flyway 默认等不匹配叙事 | [docs/README.md](../README.md)、[AGENTS.md](../../AGENTS.md) |
| P0 | 修正功能设计入口到 system、monitor、tool/gen、workflow、demo 功能域 | [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md) |
| P1 | 梳理 SQL 脚本、API、响应码与当前异常模型 | [docs/reference/README.md](../reference/README.md) |
| P1 | 收敛评审清单和模板，让它们检查真实模块边界 | [docs/reviews/README.md](../reviews/README.md) |
| P1 | 标记 workflow 和发布脚本中的历史路径风险 | [deploy/release/README.md](../../deploy/release/README.md) |
| P2 | 将高频文档治理规则转成自动检查计划 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |

## 开发约束

- 当前后端已经是 JDK 17 / Spring Boot 3.5.x，不再把“迁移到 Boot 3”当作待办事实。
- 当前数据库迁移事实是 SQL 脚本，不是 Flyway。
- 当前前端已经存在 `web/` Vue 3 应用，不再规划不存在的 `apps/projectpilot-web`。
- workflow 中仍引用 `services/callcenter-server` 的内容必须视为历史残留。
- 工程治理服务于当前 RuoYi-Vue-Plus 重构收敛，不反客为主。

## 验收标准

- 入口文档不再把当前系统描述为 ProjectPilot 项目管理 MVP。
- 架构文档能从代码地图定位到真实模块。
- 设计文档只保留当前系统已有或明确准备扩展的功能域。
- 发布文档明确当前 workflow 路径风险。
- 评审、测试、验证材料能检查真实代码结构和文档同步关系。

## 风险

- `.github/workflows` 仍可能无法在当前路径下成功构建。
- `services/callcenter-server` 仍有空目录或构建残留，容易误导自动化。
- 上游 RuoYi-Vue-Plus README 与仓库级文档存在不同语境，引用时要区分。
