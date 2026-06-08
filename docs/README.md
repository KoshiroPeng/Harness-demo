---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 文档导航总入口，按任务场景组织研发、评审、测试与发布文档。
---

# 文档导航总入口

## 目标

本文档作为 ProjectPilot 仓库的统一文档入口，按“我现在要做什么”组织现有文档，帮助开发、测试、评审和发布过程快速定位必读材料。

当前仓库主线已经调整为 Web 产品研发优先。发布、回滚、环境和可观测性材料继续保留，但定位为支撑层。

## 推荐阅读顺序

如果你是第一次进入这个仓库，建议按下面顺序建立全局认识：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
3. [docs/architecture/harness-engineering-reference.md](architecture/harness-engineering-reference.md)
4. [docs/design/web-mvp-roadmap.md](design/web-mvp-roadmap.md)
5. [docs/plans/current-sprint.md](plans/current-sprint.md)
6. [docs/reviews/README.md](reviews/README.md)

## 按目录浏览

| 文档目录 | 入口 |
| --- | --- |
| 架构文档 | [docs/architecture/README.md](architecture/README.md) |
| Harness Engineering 纠偏说明 | [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md) |
| Harness Engineering 参考手册 | [docs/architecture/harness-engineering-reference.md](architecture/harness-engineering-reference.md) |
| 编码规范 | [docs/conventions/README.md](conventions/README.md) |
| 文档元数据规范 | [docs/conventions/document-metadata.md](conventions/document-metadata.md) |
| 任务启动清单 | [docs/conventions/task-startup-checklist.md](conventions/task-startup-checklist.md) |
| 设计文档 | [docs/design/README.md](design/README.md) |
| 计划文档 | [docs/plans/README.md](plans/README.md) |
| 任务状态模板 | [docs/plans/task-status-template.md](plans/task-status-template.md) |
| 参考文档 | [docs/reference/README.md](reference/README.md) |
| 评审清单 | [docs/reviews/README.md](reviews/README.md) |
| 验证证据模板 | [docs/reviews/templates/verification-evidence-template.md](reviews/templates/verification-evidence-template.md) |
| 发布材料 | [deploy/release/README.md](../deploy/release/README.md) |
| 可观测性材料 | [deploy/observability/README.md](../deploy/observability/README.md) |

## 场景导航

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 了解当前 Web MVP 主线 | [docs/design/web-mvp-roadmap.md](design/web-mvp-roadmap.md) |
| 判断 Harness Engineering 应该如何落到当前项目 | [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md) |
| 系统理解 Harness Engineering，并识别当前环境里的 harness 组成 | [docs/architecture/harness-engineering-reference.md](architecture/harness-engineering-reference.md) |
| 我刚开始接手任务，不知道先读什么 | [docs/conventions/task-startup-checklist.md](conventions/task-startup-checklist.md) |
| 统一记录任务执行状态 | [docs/plans/task-status-template.md](plans/task-status-template.md) |
| 统一沉淀验证证据 | [docs/reviews/templates/verification-evidence-template.md](reviews/templates/verification-evidence-template.md) |
| 开发后端代码 | [开发后端代码](#开发后端代码) |
| 开发完成后做自检 | [开发后自检导航](#开发后自检导航) |
| 做后端设计评审 | [后台设计评审](#后台设计评审) |
| 做前端设计评审 | [docs/reviews/frontend-design-review-checklist.md](reviews/frontend-design-review-checklist.md) |
| 做前端代码评审 | [docs/reviews/frontend-code-review-checklist.md](reviews/frontend-code-review-checklist.md) |
| 做需求评审 | [需求评审](#需求评审) |
| 做测试设计或测试用例评审 | [测试导航](#测试导航) |
| 做发布、回滚或主机初始化 | [发布与运行导航](#发布与运行导航) |
| 查找所有评审清单 | [评审清单导航](#评审清单导航) |
| 查找评审输出模板 | [评审输出模板导航](#评审输出模板导航) |

## 开发后端代码

开发后端代码时，建议至少按下面顺序阅读：

1. [AGENTS.md](../AGENTS.md)
2. [docs/design/web-mvp-roadmap.md](design/web-mvp-roadmap.md)
3. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
4. [docs/architecture/overview.md](architecture/overview.md)
5. [docs/architecture/boundaries.md](architecture/boundaries.md)
6. [docs/conventions/README.md](conventions/README.md)
7. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
8. [docs/conventions/testing.md](conventions/testing.md)

如果你希望先看一份更短的启动路径，再展开阅读，先看：

- [docs/conventions/task-startup-checklist.md](conventions/task-startup-checklist.md)

如果当前改动涉及以下内容，再补充阅读：

- 接口变更：[docs/reference/api-spec.yaml](reference/api-spec.yaml)
- 错误处理：[docs/conventions/error-handling.md](conventions/error-handling.md) 和 [docs/reference/error-codes.md](reference/error-codes.md)
- 数据库结构与迁移：[docs/architecture/overview.md](architecture/overview.md)
- 外部调用与分层约束：[docs/architecture/boundaries.md](architecture/boundaries.md)
- 发布影响：[deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

## 开发后自检导航

完成后端代码改动后，建议至少按下面顺序自检一次：

1. [AGENTS.md](../AGENTS.md)
2. [docs/conventions/README.md](conventions/README.md)
3. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
4. [docs/conventions/testing.md](conventions/testing.md)

建议最少确认以下事项：

- 命名、注释、日志、文件规模和方法规模符合规范。
- 没有 `System.out.println`、`e.printStackTrace()`、字段级 `@Autowired`、裸用 `RestTemplate` 或 `HttpURLConnection`。
- 新增或调整的业务逻辑有对应测试，缺陷修复有回归测试。
- 若改动涉及 API、错误码、数据库迁移、发布流程或运行材料，相关文档已经同步更新。

## 后台设计评审

做后端设计评审时，建议阅读：

1. [docs/reviews/backend-design-review-checklist.md](reviews/backend-design-review-checklist.md)
2. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
3. [docs/architecture/boundaries.md](architecture/boundaries.md)
4. [docs/conventions/naming.md](conventions/naming.md)
5. [docs/conventions/error-handling.md](conventions/error-handling.md)
6. [docs/reference/api-spec.yaml](reference/api-spec.yaml)
7. [docs/reference/error-codes.md](reference/error-codes.md)

如果设计涉及发布、环境变量、回滚或上线验证，再补充阅读：

- [deploy/release/README.md](../deploy/release/README.md)
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

## 需求评审

做需求评审时，建议阅读：

1. [docs/reviews/requirement-review-checklist.md](reviews/requirement-review-checklist.md)
2. [docs/architecture/harness-engineering-adaptation.md](architecture/harness-engineering-adaptation.md)
3. [docs/design/README.md](design/README.md)
4. [docs/plans/README.md](plans/README.md)
5. [docs/design/web-mvp-roadmap.md](design/web-mvp-roadmap.md)
6. [docs/architecture/overview.md](architecture/overview.md)

如果需求涉及既有专题能力，可补充阅读：

- [docs/design/feature-auth.md](design/feature-auth.md)
- [docs/design/feature-search.md](design/feature-search.md)
- [docs/design/feature-billing.md](design/feature-billing.md)

## 测试导航

做测试设计、补测试或评审测试用例时，建议阅读：

1. [docs/conventions/testing.md](conventions/testing.md)
2. [docs/reviews/testcase-review-checklist.md](reviews/testcase-review-checklist.md)
3. [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

如果是缺陷修复测试，还应补充阅读：

- 对应需求或设计文档
- 对应错误码文档：[docs/reference/error-codes.md](reference/error-codes.md)
- 对应代码评审清单：[docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)

## 发布与运行导航

做环境初始化、发布、回滚或发布后验证时，优先阅读：

1. [deploy/release/README.md](../deploy/release/README.md)
2. [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)
3. [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)
4. [deploy/observability/README.md](../deploy/observability/README.md)

## 评审清单导航

如果你现在处于评审阶段，统一入口见：

- [docs/reviews/README.md](reviews/README.md)

## 评审输出模板导航

如果你已经完成评审，准备沉淀评审结论、评审纪要或自检记录，统一入口见：

- [docs/reviews/templates/README.md](reviews/templates/README.md)

## 维护规则

- 新增文档后，如果会影响“开发、测试、评审、发布”的主路径，必须同步更新本文档。
- 新增目录级文档后，应优先补齐该目录的 `README.md` 或等价索引页，再把入口接入本文档。
- 如果一个任务需要同时参考多份文档，应优先把“文档组合”补进本文档，而不是让使用者自己猜。
