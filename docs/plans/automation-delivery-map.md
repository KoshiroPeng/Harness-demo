---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化接入总导航页，汇总规则来源、实施顺序、阶段入口、验收材料和当前接入状态。
---

# 自动化接入总导航页

## 目标

本文档是当前仓库自动化治理的总入口，帮助协作者快速定位：

- 规则从哪里来
- 先接哪类检查
- 各阶段分别看什么
- 结果和验收材料存放在哪里

## 推荐阅读顺序

1. [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
2. [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
3. [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
4. [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
5. [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md)
6. [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)

## 文档索引

| 类别 | 文档 |
| --- | --- |
| 自动化方向 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |
| 自动化实施顺序 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 检查定义 | [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) |
| 输出文案规范 | [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md) |
| 检查结果模板 | [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) |
| 试运行验证模板 | [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md) |
| 阶段验收清单 | [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md) |

## 阶段入口

| 阶段 | 入口 |
| --- | --- |
| 第一阶段：文档结构类硬校验 | [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md) |
| 第二阶段：历史事实误用扫描 | [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md) |
| 第三阶段：workflow 路径护栏 | [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md) |
| 第四阶段：跨文档同步提醒 | [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md) |

## 当前状态

- 第一阶段已经接入并具备持续运行基础。
- 第二阶段历史事实误用扫描已经以提醒模式接入当前文档护栏脚本。
- 第三阶段 workflow 路径护栏已经接入当前文档护栏脚本。
- 第四阶段仍属于实施预案，需要按当前微服务结构继续落地。
- 当前路径类和同步类自动化必须以最新真实结构为准：
  - 后端根目录是 [server](../../server)
  - 前端根目录是 [web](../../web)
  - SQL 事实目录是 [server/sql](../../server/sql)
  - 当前 workflow 目录是 [.github/workflows](../../.github/workflows)

## 我现在要做什么

| 场景 | 先看哪里 |
| --- | --- |
| 想了解自动化总方向 | [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) |
| 想知道按什么顺序推进 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 想知道某个检查项怎么定义 | [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) |
| 想统一 CI 或脚本输出 | [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md) |
| 想做阶段验收 | [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md) |
| 想记录检查执行结果 | [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) |
| 想记录试运行验证 | [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md) |

## 维护规则

- 自动化阶段发生合并、删除或级别调整时，必须同步更新本文档。
- 新增自动化文档后，如果影响入口、验收或输出口径，必须同步更新本文档。
- 路径相关自动化说明必须持续与 [docs/architecture/code-map.md](../architecture/code-map.md) 保持一致。
