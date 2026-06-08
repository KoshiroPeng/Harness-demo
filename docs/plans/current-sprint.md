---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 当前迭代计划，聚焦文档代码对齐、历史残留清理、reference 收敛、workflow 路径修正与 Harness 护栏落地。
---

# 当前迭代计划

## 迭代目标

把 HernessDemo 从“重构后文档与代码大量不一致”的状态，收敛为“代码地图清楚、文档入口可信、发布路径可核对、Harness 护栏可执行”的状态。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 将文档主线对齐当前 RuoYi-Vue-Plus 代码事实 | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/overview.md](../architecture/overview.md) |
| P0 | 清理 ProjectPilot、CallCenter、Flyway 默认等不匹配叙事 | [docs/README.md](../README.md)、[AGENTS.md](../../AGENTS.md) |
| P0 | 修正功能设计入口到 system、monitor、tool/gen、workflow、demo 功能域 | [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) |
| P1 | 梳理 API 摘要、响应码与当前异常模型 | [docs/reference/README.md](../reference/README.md)、[docs/reference/error-codes.md](../reference/error-codes.md) |
| P1 | 为 SQL 脚本更新补充变更模板和验证清单 | [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)、[server/script/sql](../../server/script/sql) |
| P1 | 收敛评审清单和模板，让它们检查真实模块边界 | [docs/reviews/README.md](../reviews/README.md) |
| P1 | 修正 workflow 并让发布脚本路径可核对 | [deploy/release/README.md](../../deploy/release/README.md) |
| P2 | 将高频文档治理规则转成自动检查计划 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |

## 开发约束

- 当前后端已经是 JDK 17 / Spring Boot 3.5.x，不再把“迁移到 Boot 3”当作待办事实。
- 当前数据库迁移事实是 SQL 脚本，不是 Flyway。
- 当前前端已经存在 `web/` Vue 3 应用，不再规划不存在的 `apps/projectpilot-web`。
- workflow 必须指向真实 `server/`、`web/` 与 `deploy/` 路径。
- 仓库级 API 摘要只列已从真实 Controller 核对过的代表入口，不替代运行时 SpringDoc。
- SQL 变更模板只约束当前脚本体系，不引入 Flyway 或新的迁移工具。
- 工程治理服务于当前 RuoYi-Vue-Plus 重构收敛，不反客为主。

## 验收标准

- 入口文档不再把当前系统描述为 ProjectPilot 项目管理 MVP。
- 架构文档能从代码地图定位到真实模块。
- 设计文档只保留当前系统已有或明确准备扩展的功能域。
- 功能域设计能从 system、monitor、tool/gen、workflow、demo 定位到真实后端、前端、菜单和权限脚本入口。
- 发布文档明确当前 workflow 路径护栏。
- reference 文档能区分 `R<T>`、`TableDataInfo<T>`、Sa-Token 异常处理和当前 i18n 消息事实。
- SQL 变更清单能覆盖初始化脚本、升级脚本、多数据库兼容、发布验证和回滚影响。
- 评审、测试、验证材料能检查真实代码结构和文档同步关系。

## 本轮完成状态

- 文档主线已对齐当前 RuoYi-Vue-Plus 事实，入口、架构、设计、reference、评审、发布和 Harness 自动化计划已经形成导航闭环。
- 功能设计已从泛化 roadmap 收敛到 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)，覆盖 system、monitor、tool/gen、workflow、demo 的后端入口、前端入口、菜单权限和维护边界。
- 已知前后端接口差异已记录到 [docs/reference/README.md](../reference/README.md)，包括 workflow definition XML 路径差异和 monitor cache 前端残留。
- 文档治理验证证据已沉淀到 [docs/reviews/verification-evidence-doc-governance-2026-06-08.md](../reviews/verification-evidence-doc-governance-2026-06-08.md)。
- 当前仍未修改业务代码；workflow definition 与 monitor cache 的前端残留应作为后续代码任务处理。

## 结束判定

在“只改文档、不修改业务代码”的边界下，本轮文档治理任务已完成。

已完成：

- 文档与当前代码事实对齐。
- 文档导航和目录索引闭环。
- Harness Engineering 落地口径收敛。
- API、响应码、SQL、发布、评审和验证材料同步。
- 已知前后端差异记录到 reference 与 backlog。

不在本轮完成：

- 修复前端 API 残留。
- 补齐或删除后端接口。
- 执行后端、前端或发布 workflow 的运行验证。

## 风险

- `.github/workflows` 后续仍可能因环境变量、密钥或远端主机配置缺失而无法完成发布。
- 历史 `services/callcenter-*` 口径仍可能从旧分支或旧文档回流，需要持续扫描。
- 前端 API 客户端仍可能存在后端没有对应 Controller 的历史残留，需要按代码任务单独修复。
- 上游 RuoYi-Vue-Plus README 与仓库级文档存在不同语境，引用时要区分。
