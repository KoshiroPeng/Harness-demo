---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 文档导航总入口，按当前微服务项目的开发、评审、测试、发布与治理场景组织精简入口。
---

# 文档导航总入口

## 目标

本文档是 HarnessBase 的统一文档入口，负责把“项目是什么、代码在哪里、任务怎么落地、规则到哪查看”组织成一条可直接导航的主路径。

当前文档体系围绕真实仓库结构组织：

- [server](../server)：后端微服务工程
- [web](../web)：前端管理后台
- [deploy](../deploy)：发布、回滚、观测支撑材料
- [deploy/compose](../deploy/compose)：整套微服务 docker-compose 部署入口
- [.github/workflows](../.github/workflows)：CI 与发布 workflow

## 推荐阅读顺序

第一次进入仓库时，建议按下面顺序建立全局认识：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
3. [docs/architecture/code-map.md](architecture/code-map.md)
4. [docs/architecture/target-technology-baseline.md](architecture/target-technology-baseline.md)
5. [docs/architecture/overview.md](architecture/overview.md)
6. [docs/architecture/boundaries.md](architecture/boundaries.md)
7. [docs/architecture/business-extension-baseline.md](architecture/business-extension-baseline.md)
8. [docs/conventions/development-execution-guide.md](conventions/development-execution-guide.md)
9. [docs/reviews/README.md](reviews/README.md)

## 入口导航

| 你要解决什么问题 | 入口 |
| --- | --- |
| 先理解整个仓库 | [README.md](../README.md)、[docs/architecture/overview.md](architecture/overview.md) |
| 找到真实代码入口 | [docs/architecture/code-map.md](architecture/code-map.md) |
| 理解 Harness Engineering 如何落地 | [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md) |
| 为新业务生成仓库影响图 | [docs/architecture/business-extension-baseline.md#仓库影响图](architecture/business-extension-baseline.md#仓库影响图) |
| 确认技术与版本基线 | [docs/architecture/target-technology-baseline.md](architecture/target-technology-baseline.md) |
| 后端工程入口 | [server/README.md](../server/README.md) |
| 前端工程入口 | [web/README.md](../web/README.md) |
| GitHub workflow 入口 | [.github/README.md](../.github/README.md) |
| 发布与回滚材料 | [deploy/release/README.md](../deploy/release/README.md) |
| docker-compose 部署入口 | [deploy/compose/README.md](../deploy/compose/README.md) |
| 可观测性材料 | [deploy/observability/README.md](../deploy/observability/README.md) |
| 架构专题文档 | [docs/architecture/README.md](architecture/README.md) |
| 编码规范 | [docs/conventions/README.md](conventions/README.md) |
| 功能设计 | [docs/design/README.md](design/README.md) |
| 计划文档 | [docs/plans/README.md](plans/README.md) |
| 参考文档 | [docs/reference/README.md](reference/README.md) |
| 评审清单 | [docs/reviews/README.md](reviews/README.md) |
| 评审模板 | [docs/reviews/templates/README.md](reviews/templates/README.md) |

## 场景导航

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 了解当前仓库真实结构 | [docs/architecture/code-map.md](architecture/code-map.md) |
| 新增业务功能或业务域 | [docs/conventions/task-startup-checklist.md#新增业务功能](conventions/task-startup-checklist.md#新增业务功能) |
| 开发后端代码 | [docs/conventions/task-startup-checklist.md#开发后端代码](conventions/task-startup-checklist.md#开发后端代码) |
| 开发前端页面 | [docs/conventions/task-startup-checklist.md#开发前端代码](conventions/task-startup-checklist.md#开发前端代码) |
| 修改数据库脚本 | [docs/conventions/task-startup-checklist.md#数据库脚本变更](conventions/task-startup-checklist.md#数据库脚本变更) |
| 修改认证、网关、权限或服务间调用 | [docs/architecture/boundaries.md](architecture/boundaries.md)、[docs/design/feature-auth.md](design/feature-auth.md) |
| 修改系统管理、监控、代码生成、任务或文件服务 | [docs/design/feature-admin-domains.md](design/feature-admin-domains.md) |
| 核对 API 摘要、SpringDoc 或接口事实 | [docs/reference/README.md](reference/README.md) |
| 推进文档或 workflow 自动化检查 | [docs/conventions/automation-check-catalog.md](conventions/automation-check-catalog.md)、[.github/scripts/doc_guardrails.py](../.github/scripts/doc_guardrails.py) |
| 记录验证或试运行结果 | [docs/reviews/templates/verification-evidence-template.md](reviews/templates/verification-evidence-template.md) |
| 查看后续待办 | [docs/plans/backlog.md](plans/backlog.md) |
| 快速判断开发前看什么、开发后查什么 | [docs/conventions/development-execution-guide.md](conventions/development-execution-guide.md) |
| 判断某类改动还要同步哪些文档 | [docs/conventions/change-trigger-matrix.md](conventions/change-trigger-matrix.md) |
| 做代码评审或开发后自检 | [docs/conventions/task-startup-checklist.md#做代码评审或开发后自检](conventions/task-startup-checklist.md#做代码评审或开发后自检) |
| 做需求或设计评审 | [docs/conventions/task-startup-checklist.md#做需求或设计评审](conventions/task-startup-checklist.md#做需求或设计评审) |
| 做发布、回滚或上线验证 | [docs/conventions/task-startup-checklist.md#做发布回滚或上线验证](conventions/task-startup-checklist.md#做发布回滚或上线验证) |
| 设计或执行整套 docker-compose 部署 | [deploy/compose/README.md](../deploy/compose/README.md)、[deploy/release/release-checklist.md](../deploy/release/release-checklist.md) |
| 做文档整理或规则治理 | [文档治理规范](#文档治理规范) |

## 文档分层

当前仓库文档建议按以下分层理解：

- 仓库入口层： [README.md](../README.md)、[AGENTS.md](../AGENTS.md)、本文档
- 架构事实层： [docs/architecture/code-map.md](architecture/code-map.md)、[docs/architecture/overview.md](architecture/overview.md)、[docs/architecture/target-technology-baseline.md](architecture/target-technology-baseline.md)
- Harness 执行层： [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)、[docs/architecture/business-extension-baseline.md](architecture/business-extension-baseline.md)、[docs/conventions/development-execution-guide.md](conventions/development-execution-guide.md)
- 执行规则层： [docs/conventions/README.md](conventions/README.md)
- 设计与参考层： [docs/design/README.md](design/README.md)、[docs/reference/README.md](reference/README.md)
- 评审与验证层： [docs/reviews/README.md](reviews/README.md)
- 计划层： [docs/plans/README.md](plans/README.md)

## 任务启动清单

开发、评审、测试、发布和文档治理的详细联读顺序，统一维护在 [docs/conventions/task-startup-checklist.md](conventions/task-startup-checklist.md)。本文档只保留总入口和场景导航，避免总导航与执行清单两处漂移。

## 文档治理规范

文档整理或规则治理时优先阅读：

1. [docs/architecture/code-map.md](architecture/code-map.md)
2. [docs/conventions/document-links.md](conventions/document-links.md)
3. [docs/conventions/document-metadata.md](conventions/document-metadata.md)
4. [docs/conventions/automation-check-catalog.md](conventions/automation-check-catalog.md)
5. [docs/conventions/automation-message-guidelines.md](conventions/automation-message-guidelines.md)
6. [docs/plans/README.md](plans/README.md)

## 维护规则

- 新增文档后，如果会影响开发、测试、评审、发布或文档治理主路径，必须同步更新本文档。
- 新增目录级文档后，应优先补齐该目录的 `README.md` 或等价索引页。
- 删除文档后，必须清理所有入口引用。
- 如果一个任务需要同时参考多份文档，应优先把文档组合补进本文档。
