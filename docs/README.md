---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 文档导航总入口

## 目标

本文档作为 HernessDemo 仓库的统一文档入口，按“我要做什么”组织现有文档，帮助开发、测试、评审和交付过程快速定位必须阅读的材料。

## 使用方式

如果你不确定该先看哪份文档，先看本文档，再根据当前任务进入对应场景。

如果你已经知道要看的文档目录，也可以直接从“按目录浏览”进入对应目录首页。

## 按目录浏览

| 文档目录 | 入口 |
| --- | --- |
| 架构文档 | [docs/architecture/overview.md](architecture/overview.md) |
| 编码规范 | [docs/conventions/README.md](conventions/README.md) |
| 交付文档 | [docs/delivery/README.md](delivery/README.md) |
| 运维文档 | [docs/operations/README.md](operations/README.md) |
| 设计文档 | [docs/design/README.md](design/README.md) |
| 计划文档 | [docs/plans/README.md](plans/README.md) |
| 参考文档 | [docs/reference/README.md](reference/README.md) |
| 评审清单 | [docs/reviews/README.md](reviews/README.md) |
| 治理文档 | [docs/governance/README.md](governance/README.md) |

## 场景导航

| 我现在要做什么 | 优先阅读 |
| --- | --- |
| 开发后端代码 | [开发后端代码导航](#开发后端代码) |
| 开发完成后做自检 | [开发后自检导航](#开发后自检导航) |
| 做后台设计评审 | [后台设计评审导航](#后台设计评审) |
| 做需求评审 | [需求评审导航](#需求评审) |
| 做测试或补测试 | [测试导航](#测试导航) |
| 做发布、回滚或环境初始化 | [交付与运维导航](#交付与运维导航) |
| 查找所有评审清单 | [评审清单导航](#评审清单导航) |

## 开发后端代码

开发后端代码时，建议至少按下面顺序查看：

1. [AGENTS.md](../AGENTS.md)
2. [docs/architecture/overview.md](architecture/overview.md)
3. [docs/architecture/boundaries.md](architecture/boundaries.md)
4. [docs/conventions/README.md](conventions/README.md)
5. [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)
6. [docs/conventions/testing.md](conventions/testing.md)

如果当前改动涉及以下内容，再额外补读：

- 接口变更： [docs/reference/api-spec.yaml](reference/api-spec.yaml)
- 错误处理： [docs/conventions/error-handling.md](conventions/error-handling.md) 和 [docs/reference/error-codes.md](reference/error-codes.md)
- 数据库结构： [docs/delivery/pipelines.md](delivery/pipelines.md) 与 Flyway 相关规则
- 外部调用： [docs/architecture/boundaries.md](architecture/boundaries.md) 中 `ApiClient` 约束
- 发布影响： [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)

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
- 若改动涉及 API、错误码、数据库迁移、交付流程或运行手册，相关文档已经同步更新。

## 后台设计评审

做后台设计评审时，建议阅读：

1. [docs/reviews/backend-design-review-checklist.md](reviews/backend-design-review-checklist.md)
2. [docs/architecture/boundaries.md](architecture/boundaries.md)
3. [docs/conventions/naming.md](conventions/naming.md)
4. [docs/conventions/error-handling.md](conventions/error-handling.md)
5. [docs/reference/api-spec.yaml](reference/api-spec.yaml)
6. [docs/reference/error-codes.md](reference/error-codes.md)

若设计涉及交付、配置、发布、回滚，再补读：

- [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)
- [docs/operations/config-and-secrets.md](operations/config-and-secrets.md)

## 需求评审

做需求评审时，建议阅读：

1. [docs/reviews/requirement-review-checklist.md](reviews/requirement-review-checklist.md)
2. [docs/design/README.md](design/README.md)
3. [docs/plans/README.md](plans/README.md)
4. [docs/architecture/overview.md](architecture/overview.md)

若需求涉及认证、搜索、计费等既有方向，可补读：

- [docs/design/feature-auth.md](design/feature-auth.md)
- [docs/design/feature-search.md](design/feature-search.md)
- [docs/design/feature-billing.md](design/feature-billing.md)

## 测试导航

做测试设计、补测试或评审测试用例时，建议阅读：

1. [docs/conventions/testing.md](conventions/testing.md)
2. [docs/reviews/testcase-review-checklist.md](reviews/testcase-review-checklist.md)
3. [docs/operations/release-verification.md](operations/release-verification.md)

如果是缺陷修复测试，还应补读：

- 对应需求或设计文档
- 对应错误码文档： [docs/reference/error-codes.md](reference/error-codes.md)
- 对应代码评审清单： [docs/reviews/backend-code-review-checklist.md](reviews/backend-code-review-checklist.md)

## 交付与运维导航

做环境初始化、发布、回滚或发布后验证时，优先阅读：

1. [docs/delivery/delivery-operations-map.md](delivery/delivery-operations-map.md)
2. [docs/operations/github-environment-setup.md](operations/github-environment-setup.md)
3. [docs/operations/release-verification.md](operations/release-verification.md)
4. [docs/operations/rollback-runbook.md](operations/rollback-runbook.md)
5. [docs/operations/remote-host-bootstrap.md](operations/remote-host-bootstrap.md)

## 评审清单导航

如果你现在处于评审阶段，统一入口见：

- [docs/reviews/README.md](reviews/README.md)

## 维护规则

- 新增文档后，如果会影响“开发、测试、评审、交付”的主路径，必须同步更新本文档。
- 新增目录级文档后，应优先补齐该目录的 `README.md` 或等价索引页，再把入口接入本文档。
- 如果一个任务需要同时参考多份文档，应优先把“文档组合”补进本文档，而不是让使用者自己猜。
