---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HernessDemo 文档导航总入口，按任务场景组织架构、开发、评审、测试、发布与文档治理材料。
---

# 文档导航总入口

## 目标

本文档是 HernessDemo 的统一文档入口。当前仓库的真实代码主线是 RuoYi-Vue-Plus 多租户后台管理系统，文档必须围绕现有 `server/`、`web/`、`deploy/` 和 `.github/workflows/` 事实组织。

## 推荐阅读顺序

第一次进入仓库时，建议按下面顺序建立全局认识：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/code-map.md](architecture/code-map.md)
3. [docs/architecture/target-technology-baseline.md](architecture/target-technology-baseline.md)
4. [docs/architecture/overview.md](architecture/overview.md)
5. [docs/architecture/boundaries.md](architecture/boundaries.md)
6. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
7. [docs/plans/current-sprint.md](plans/current-sprint.md)
8. [docs/reviews/README.md](reviews/README.md)

## 按目录浏览

| 文档目录 | 入口 |
| --- | --- |
| 架构文档 | [docs/architecture/README.md](architecture/README.md) |
| 当前代码地图 | [docs/architecture/code-map.md](architecture/code-map.md) |
| 技术基线 | [docs/architecture/target-technology-baseline.md](architecture/target-technology-baseline.md) |
| 编码规范 | [docs/conventions/README.md](conventions/README.md) |
| 功能设计 | [docs/design/README.md](design/README.md) |
| 计划文档 | [docs/plans/README.md](plans/README.md) |
| 参考文档 | [docs/reference/README.md](reference/README.md) |
| 评审清单 | [docs/reviews/README.md](reviews/README.md) |
| 评审输出模板 | [docs/reviews/templates/README.md](reviews/templates/README.md) |
| 发布材料 | [deploy/release/README.md](../deploy/release/README.md) |
| 可观测性材料 | [deploy/observability/README.md](../deploy/observability/README.md) |

## 场景导航

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 了解当前仓库真实结构 | [docs/architecture/code-map.md](architecture/code-map.md) |
| 开发后端功能 | [开发后端代码](conventions/task-startup-checklist.md#开发后端代码) |
| 开发前端页面 | [开发前端代码](conventions/task-startup-checklist.md#开发前端代码) |
| 修改数据库脚本 | [数据库脚本变更](conventions/task-startup-checklist.md#数据库脚本变更) |
| 修改认证、权限或租户能力 | [docs/design/feature-auth.md](design/feature-auth.md) |
| 修改工作流、代码生成、监控或系统管理 | [docs/design/feature-admin-domains.md](design/feature-admin-domains.md) |
| 修复已知前后端接口差异 | [docs/plans/frontend-backend-api-drift-fix-brief.md](plans/frontend-backend-api-drift-fix-brief.md) |
| 做开发后自检 | [做代码评审或开发后自检](conventions/task-startup-checklist.md#做代码评审或开发后自检) |
| 做需求或设计评审 | [做需求或设计评审](conventions/task-startup-checklist.md#做需求或设计评审) |
| 做发布、回滚或主机初始化 | [做发布、回滚或上线验证](conventions/task-startup-checklist.md#做发布回滚或上线验证) |
| 做文档整理或规则治理 | [文档治理规范](#文档治理规范) |

## 任务启动清单

开发、评审、测试、发布和文档治理的详细联读顺序，统一维护在 [docs/conventions/task-startup-checklist.md](conventions/task-startup-checklist.md)。

本文档只保留总入口和场景导航，不再重复展开执行清单，避免总导航与任务清单两处漂移。

## 文档治理规范

文档整理或规则治理时优先阅读：

1. [docs/architecture/code-map.md](architecture/code-map.md)
2. [docs/conventions/document-links.md](conventions/document-links.md)
3. [docs/conventions/document-metadata.md](conventions/document-metadata.md)
4. [docs/conventions/harness-automation-roadmap.md](conventions/harness-automation-roadmap.md)
5. [docs/plans/task-status-template.md](plans/task-status-template.md)

## 维护规则

- 新增文档后，如果会影响开发、测试、评审、发布或文档治理主路径，必须同步更新本文档。
- 新增目录级文档后，应优先补齐该目录的 `README.md` 或等价索引页。
- 删除文档后，必须清理所有入口引用。
- 如果一个任务需要同时参考多份文档，应优先把文档组合补进本文档。
