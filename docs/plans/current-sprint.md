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
| 文档与 workflow 护栏脚本 | 已通过 | `python .github/scripts/doc_guardrails.py` 可通过，当前覆盖 A01/A02/A03/A04/A05，其中 A04 为提醒模式 |
| 后端整仓构建 | 已通过 | 在 [server](../../server) 下执行 `mvn -B -DskipTests package` 成功 |
| 前端依赖安装 | 已通过 | 在 [web](../../web) 下执行 `npm.cmd install` 成功；本机 PowerShell 执行策略会阻止 `npm.ps1`，需改用 `npm.cmd` |
| 前端生产构建 | 已通过 | 在 [web](../../web) 下执行 `npm.cmd run build:prod` 成功 |
| workflow 口径纠偏 | 已完成文档收口 | 已改为 Maven + npm + 模块级制品上传，并同步 [.github/README.md](../../.github/README.md)、[deploy/release/README.md](../../deploy/release/README.md) 与自动化治理入口 |

## 当前文档收口进展

截至 2026-06-09，仓库级入口文档已经完成一轮系统性重写与统一：

- 根入口 [README.md](../../README.md) 已改成项目定位、模块概览、技术基线和阅读顺序的总入口。
- 协作入口 [AGENTS.md](../../AGENTS.md) 已统一当前项目事实、命名语境、导航入口与历史边界提醒。
- 文档总入口 [docs/README.md](../README.md) 已改成“入口导航 + 场景导航 + 文档分层”的主导航页。
- 架构主入口 [docs/architecture/overview.md](../architecture/overview.md)、[docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md) 已分别收敛为“总览 / 代码地图 / 技术事实”三层。
- 后端、前端、workflow、发布、评审模板等目录入口已同步统一术语与导航口径。
- Harness Engineering 主路径已收敛为 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)、[docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)、[docs/conventions/development-execution-guide.md](../conventions/development-execution-guide.md) 和 [docs/conventions/change-trigger-matrix.md](../conventions/change-trigger-matrix.md)。
- 自动化 A01-A05 已接入 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 和 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)，其中 A04 历史事实误用扫描以提醒模式运行；后续重点转为 A06-A08 同步提醒。

## 当前遗留风险

1. 前端构建虽然成功，但存在较明显的 bundle size warning，后续需要在真实业务开发前评估首屏与按需加载优化。
2. 前端依赖对本机较新 Node 版本存在 `EBADENGINE` 告警，当前未阻塞安装，但后续应补齐团队推荐 Node 版本说明。
3. 发布 workflow 文档口径已经切到模块级制品思路，但仍缺少真实远端环境的一次端到端演练证据。
