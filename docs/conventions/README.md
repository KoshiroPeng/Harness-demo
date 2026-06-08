---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 工程规范目录入口，汇总编码、测试、日志、命名、文档治理与任务启动规则。
---

# 工程规范总览

本目录记录 HernessDemo 的工程规范。根规则以 [AGENTS.md](../../AGENTS.md) 为准，本文档负责把日常开发细则拆分到可维护的位置。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 命名规范 | [docs/conventions/naming.md](naming.md) |
| 错误处理 | [docs/conventions/error-handling.md](error-handling.md) |
| 测试规范 | [docs/conventions/testing.md](testing.md) |
| 日志规范 | [docs/conventions/logging.md](logging.md) |
| 文件规模 | [docs/conventions/file-size.md](file-size.md) |
| 方法规模 | [docs/conventions/method-size.md](method-size.md) |
| 文档链接规范 | [docs/conventions/document-links.md](document-links.md) |
| 文档元数据规范 | [docs/conventions/document-metadata.md](document-metadata.md) |
| Harness 自动化落地方案 | [docs/conventions/harness-automation-roadmap.md](harness-automation-roadmap.md) |
| 任务启动清单 | [docs/conventions/task-startup-checklist.md](task-startup-checklist.md) |
| 评审清单总览 | [docs/reviews/README.md](../reviews/README.md) |
| 验证证据模板 | [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) |
| API 摘要 | [docs/reference/api-spec.yaml](../reference/api-spec.yaml) |
| 响应码与错误消息 | [docs/reference/error-codes.md](../reference/error-codes.md) |
| 发布材料 | [deploy/release/README.md](../../deploy/release/README.md) |
| 可观测性材料 | [deploy/observability/README.md](../../deploy/observability/README.md) |

## 当前技术基线

- 后端使用 JDK 17、Spring Boot 3.5.x、Maven 多模块。
- 后端基座为 RuoYi-Vue-Plus 5.6.1。
- 持久化使用 MyBatis-Plus Boot 3、dynamic-datasource 和 SQL 脚本。
- 当前没有 Flyway migration 体系。
- 前端使用 Vue 3、TypeScript、Vite、Element Plus、Pinia。
- 测试使用 JUnit 5 与 Vitest。

详细说明见 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)。

## 基本原则

- 优先遵循项目已有模式。
- 不为局部需求引入新框架或全局抽象。
- 后端新增能力按 `ruoyi-admin`、`ruoyi-common-*`、`ruoyi-modules/*`、`ruoyi-extend/*` 的真实边界放置。
- 前端新增能力按 `web/src/api`、`web/src/views`、`web/src/router`、`web/src/store` 的真实结构放置。
- 新增业务代码必须同步测试。
- 涉及 API、响应码、SQL、发布流程或架构边界的变更必须同步文档。

## 代码规模

- 单个 `.java` 文件建议不超过 300 行。
- 单个方法建议不超过 50 行。
- 超限前优先拆分职责，而不是靠格式压缩规避限制。

## 注入与命名空间规范

- 禁止字段级 `@Autowired`。
- 必须使用构造器注入。
- 推荐 Lombok `@RequiredArgsConstructor`。
- 新代码统一使用 `jakarta.*` 命名空间。
- auth、tenant、log、cache、SSE、WebSocket、外部 API 客户端等横切能力优先通过已有 common 模块接入。

## 提交前自检

提交前至少确认：

- 代码可以编译或已说明无法运行的原因。
- 新增或变更业务逻辑有对应测试。
- 没有新增 `System.out.println` 或 `e.printStackTrace()`。
- 没有直接裸用第三方 HTTP 客户端绕过统一封装。
- SQL、API、响应码、发布材料等相关文档已经同步更新。

如果需要按任务查看“开发前必读 + 开发后自检 + 评审清单”，统一入口见 [docs/README.md](../README.md)。
