---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 当前迭代计划，聚焦文档与当前微服务代码事实对齐、发布路径纠偏与 Harness 护栏落地。
---

# 当前迭代计划

## 迭代目标

把 HarnessBase 从“文档与当前代码大量不一致”的状态，收口到“代码地图清楚、文档入口可信、发布路径可核对、Harness 护栏可执行”的状态。

## 本迭代范围

| 优先级 | 事项 | 产出 |
| --- | --- | --- |
| P0 | 将文档主线对齐当前微服务代码事实 | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/overview.md](../architecture/overview.md) |
| P0 | 清理旧单体、旧前端栈、旧 SQL 路径等过期叙事 | [docs/README.md](../README.md)、[AGENTS.md](../../AGENTS.md) |
| P0 | 修正功能设计入口到当前 `system`、`monitor`、`tool`、`auth`、`file` 能力 | [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)、[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) |
| P1 | 梳理 API 摘要、响应码与当前异常模型 | [docs/reference/README.md](../reference/README.md)、[docs/reference/error-codes.md](../reference/error-codes.md) |
| P1 | 为 SQL 脚本更新补充变更模板和验证清单 | [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)、[server/sql](../../server/sql) |
| P1 | 收敛评审清单和模板，让它们检查真实模块边界 | [docs/reviews/README.md](../reviews/README.md) |
| P1 | 修正 workflow 并让发布脚本路径可核对 | [deploy/release/README.md](../../deploy/release/README.md) |
| P2 | 将高频文档治理规则转成自动化检查 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) |

## 当前验证进展

截至 2026-06-09，本迭代与“可运行基线”直接相关的事项状态如下：

| 事项 | 当前状态 | 说明 |
| --- | --- | --- |
| 文档护栏脚本 | 已通过 | `python .github/scripts/doc_guardrails.py` 可通过 |
| 后端整仓构建 | 已通过 | 在 [server](../../server) 下执行 `mvn -B -DskipTests package` 成功 |
| 前端依赖安装 | 已通过 | 在 [web](../../web) 下执行 `npm.cmd install` 成功；本机 PowerShell 执行策略会阻止 `npm.ps1`，需改用 `npm.cmd` |
| 前端生产构建 | 已通过 | 在 [web](../../web) 下执行 `npm.cmd run build:prod` 成功 |
| workflow 口径纠偏 | 进行中 | 已改为 Maven + npm + 模块级制品上传，等待本轮文档与提交收口 |

## 当前遗留风险

1. 前端构建虽然成功，但存在较明显的 bundle size warning，后续需要在真实业务开发前评估首屏与按需加载优化。
2. 前端依赖对本机较新 Node 版本存在 `EBADENGINE` 告警，当前未阻塞安装，但后续应补齐团队推荐 Node 版本说明。
3. 发布 workflow 已经切到模块级制品思路，但还缺少真实远端环境的一次端到端演练证据。
