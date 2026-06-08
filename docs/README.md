---
last_updated: 2026-06-08
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
| 开发后端功能 | [开发后端功能](#开发后端功能) |
| 开发前端页面 | [开发前端页面](#开发前端页面) |
| 修改数据库脚本 | [数据库脚本变更](#数据库脚本变更) |
| 修改认证、权限或租户能力 | [docs/design/feature-auth.md](design/feature-auth.md) |
| 修改工作流、代码生成、监控或系统管理 | [docs/design/backend-admin-roadmap.md](design/backend-admin-roadmap.md) |
| 做开发后自检 | [开发后自检](#开发后自检) |
| 做需求或设计评审 | [评审导航](#评审导航) |
| 做发布、回滚或主机初始化 | [发布与运行](#发布与运行) |
| 做文档整理或规则治理 | [文档治理](#文档治理) |

## 开发后端功能

建议至少按下面顺序阅读：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/code-map.md](architecture/code-map.md)
3. [docs/architecture/boundaries.md](architecture/boundaries.md)
4. [docs/architecture/data-flow.md](architecture/data-flow.md)
5. [docs/conventions/README.md](conventions/README.md)
6. [docs/conventions/testing.md](conventions/testing.md)
7. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)

如果涉及 API、响应码或 SQL，再补充：

- [docs/reference/api-spec.yaml](reference/api-spec.yaml)
- [docs/reference/error-codes.md](reference/error-codes.md)
- [server/script/sql](../server/script/sql)

## 开发前端页面

建议至少按下面顺序阅读：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/code-map.md](architecture/code-map.md)
3. [docs/design/backend-admin-roadmap.md](design/backend-admin-roadmap.md)
4. [docs/conventions/README.md](conventions/README.md)
5. [docs/reviews/frontend-design-review-checklist.md](reviews/frontend-design-review-checklist.md)
6. [docs/reviews/frontend-code-review-checklist.md](reviews/frontend-code-review-checklist.md)

前端代码事实入口：

- [web/src/api](../web/src/api)
- [web/src/views](../web/src/views)
- [web/src/router](../web/src/router)
- [web/src/store](../web/src/store)

## 数据库脚本变更

数据库结构变更必须先确认：

1. 当前脚本入口：[server/script/sql](../server/script/sql)。
2. 初始化脚本是否要更新。
3. [server/script/sql/update](../server/script/sql/update) 下是否需要新增升级脚本。
4. API、响应码、发布清单和测试是否受影响。

当前仓库没有 Flyway migration 体系，不要把 Flyway 当作已落地事实。

## 开发后自检

完成代码或文档改动后，建议至少确认：

- 文件编码保持 UTF-8。
- Markdown 链接可点击且路径存在。
- 代码事实没有被旧 `ProjectPilot`、`CallCenter`、`services/callcenter-server` 说法覆盖。
- 后端新增代码没有字段级 `@Autowired`、新增 `System.out.println`、`e.printStackTrace()` 或 `javax.*`。
- 相关测试、SQL、API、响应码、发布材料已经同步。
- 需要沉淀验证时，使用 [docs/reviews/templates/verification-evidence-template.md](reviews/templates/verification-evidence-template.md)。

## 评审导航

- 评审总入口：[docs/reviews/README.md](reviews/README.md)
- 需求评审：[docs/reviews/requirement-review-checklist.md](reviews/requirement-review-checklist.md)
- 后端设计评审：[docs/reviews/backend-design-review-checklist.md](reviews/backend-design-review-checklist.md)
- 前端设计评审：[docs/reviews/frontend-design-review-checklist.md](reviews/frontend-design-review-checklist.md)
- 后端代码评审：[docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
- 前端代码评审：[docs/reviews/frontend-code-review-checklist.md](reviews/frontend-code-review-checklist.md)
- 测试用例评审：[docs/reviews/testcase-review-checklist.md](reviews/testcase-review-checklist.md)
- 输出模板：[docs/reviews/templates/README.md](reviews/templates/README.md)

## 发布与运行

发布、回滚或发布后验证优先阅读：

1. [deploy/release/README.md](../deploy/release/README.md)
2. [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)
3. [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)
4. [deploy/observability/README.md](../deploy/observability/README.md)

注意：当前 `.github/workflows` 部分文件仍引用历史 `services/callcenter-server` 路径，真实发布前必须先修正 workflow。

## 文档治理

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
