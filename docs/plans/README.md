---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 计划文档目录入口，汇总当前迭代、后续待办与任务状态模板。
---

# 计划文档总览

## 目标

本目录沉淀 HarnessBase 当前文档与工程收敛计划，帮助协作者理解现在要修正什么、下一步准备做什么。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 当前迭代计划 | [docs/plans/current-sprint.md](current-sprint.md) |
| 后续待办 | [docs/plans/backlog.md](backlog.md) |
| 前后端接口差异修复任务说明 | [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) |
| Harness 自动化实施简报 | [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) |
| 第一阶段文档检查 CI 接入说明 | [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md) |
| 任务状态模板 | [docs/plans/task-status-template.md](task-status-template.md) |

## 使用建议

- 如果要理解当前最优先事项，先读 [docs/plans/current-sprint.md](current-sprint.md)。
- 如果要挑后续任务，读 [docs/plans/backlog.md](backlog.md)。
- 如果要修复已知前后端接口差异，读 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md)。
- 如果要开始补文档校验、链接检查、workflow 路径护栏或同步提醒，读 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)。
- 如果要把第一阶段文档结构类检查接进 CI，读 [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)。
- 如果任务跨多个模块、文档或阶段，使用 [docs/plans/task-status-template.md](task-status-template.md) 记录过程。
- 如果计划项涉及真实代码结构，先核对 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 如果任务涉及 API 摘要、SpringDoc、前端接口客户端或已知接口漂移，同时联读 [docs/reference/README.md](../reference/README.md)。

## 维护规则

- 迭代目标变化时，优先更新 [docs/plans/current-sprint.md](current-sprint.md)。
- 新增后续事项时，优先更新 [docs/plans/backlog.md](backlog.md)。
- 删除计划文档后，必须同步清理 [docs/README.md](../README.md) 和相关索引。
