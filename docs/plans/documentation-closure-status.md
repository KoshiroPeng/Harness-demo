---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 文档收口状态说明，明确哪些文档已稳定成基线、哪些按任务增量维护、哪些仍属自动化接入预案。
---

# 文档收口状态说明

## 当前结论

截至 2026-06-09，HarnessBase 的仓库级文档已经从“入口分散、事实错位”收口到“入口清晰、代码事实一致、可继续作为开发导航使用”的状态。

同日已补充一轮本地执行链验证证据：文档护栏通过，后端 Maven 整仓构建通过，前端 `npm.cmd install` 与 `npm.cmd run build:prod` 通过。当前文档不再只有结构描述，也已经能够指向最近一次真实可运行基线。

## 已稳定为基线入口的文档

- [AGENTS.md](../../AGENTS.md)
- [README.md](../../README.md)
- [docs/README.md](../README.md)
- [docs/architecture/README.md](../architecture/README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/overview.md](../architecture/overview.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [docs/architecture/boundaries.md](../architecture/boundaries.md)
- [docs/design/README.md](../design/README.md)
- [docs/plans/README.md](../plans/README.md)
- [docs/reference/README.md](../reference/README.md)
- [docs/reviews/README.md](../reviews/README.md)
- [docs/reviews/templates/README.md](../reviews/templates/README.md)
- [docs/conventions/README.md](../conventions/README.md)
- [.github/README.md](../../.github/README.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

## 按真实开发任务增量维护的文档

- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/reference/error-codes.md](../reference/error-codes.md)
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [docs/design/feature-auth.md](../design/feature-auth.md)
- [docs/plans/backlog.md](backlog.md)

## 自动化接入状态

已落地并持续维护：

- [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) 中的 A01-A03 文档护栏路线、A04 历史事实误用提醒路线和 A05 workflow 路径护栏路线
- [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)
- [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)
- [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)
- [docs/reviews/automation-a04-history-scan-pilot.md](../reviews/automation-a04-history-scan-pilot.md)
- [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

仍属后续自动化接入预案的文档：

- [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- [docs/plans/automation-delivery-map.md](automation-delivery-map.md)
- [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)

## 维护原则

1. 主入口只做必要收口，不做概念扩张。
2. 事实型文档跟着真实代码和配置变更更新。
3. 预案型文档跟着真实自动化接入动作更新，不提前写成完成态。
4. 只要出现新的构建、发布、回滚或护栏验证事实，就要优先回写到入口型文档，避免文档重新退化成“只有规则、没有证据”。
5. 目录级 `README.md` 一旦承担导航职责，就应视为正式入口文档，保持与根入口相同的术语、模块命名和链接质量。
