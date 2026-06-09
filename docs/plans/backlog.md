---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: ProjectPilot 当前阶段的持续治理待办，覆盖历史残留清理、文档同步、代码质量、发布支撑与 Harness 自动化收口。
---

# Backlog

## P0：历史残留清理

- 持续防止 `.github/workflows` 回退到旧源码路径。
- 统一发布脚本中的历史命名，例如 `harness-base`、`ruoyi-admin` 等服务名、制品名和运行口径。
- 持续扫描并清理文档中的历史产品事实误用，尤其是已不再适用的行业背景、功能范围和旧项目命名。

## P1：文档事实同步

- 基于 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md) 持续沉淀可复用的纵向切片模板。
- 文档治理主线已完成；后续仅在真实开发任务触发时，基于 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) 按需细化 `system`、`monitor`、`tool/gen`、`workflow`、`demo` 等子域设计。
- 持续校准 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)，确保仓库级 API 摘要与 SpringDoc、真实 Controller、前端 [web/src/api](../../web/src/api) 保持一致。
- 持续维护 [docs/reference/error-codes.md](../reference/error-codes.md)，确保其与 `R`、`TableDataInfo`、`HttpStatus`、i18n 消息、`GlobalExceptionHandler`、`SaTokenExceptionHandler` 对齐。
- 持续维护 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)，确保 SQL 变更模板与当前脚本体系一致。
- 如果后续再次发现前后端接口漂移，先在 [docs/reference/README.md](../reference/README.md) 记录事实，再按 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) 拆分修复任务。

## P2：代码与质量硬化

- 清理测试代码中的 `System.out.println`，并评估是否统一替换为断言、日志或测试报告输出；生产代码主路径中的同类残留已完成首轮收口。
- 按风险补齐后端单元测试和前端 Vitest 覆盖。
- 持续扫描直接跨层调用。
- `ruoyi-demo` 中 Controller 直连 Mapper 的首轮收口已完成。
- `ruoyi-admin` 登录注册链路直连 `SysUserMapper` 的一轮收口已完成：用户名、邮箱、手机号、用户 ID 查询与登录信息写入已统一回切到 `ruoyi-system` 的 `ISysUserService`。验证证据见 [docs/reviews/verification-evidence-admin-user-service-boundary-fix-2026-06-09.md](../reviews/verification-evidence-admin-user-service-boundary-fix-2026-06-09.md) 与 [docs/reviews/verification-evidence-controller-service-boundary-fix-2026-06-09.md](../reviews/verification-evidence-controller-service-boundary-fix-2026-06-09.md)。
- 裸 HTTP 客户端首轮核对已完成，当前命中集中在社会化登录 provider 适配器和基础设施层，未发现业务 Controller / Service 直接发起外部 HTTP 请求。验证证据见 [docs/reviews/verification-evidence-http-client-boundary-check-2026-06-09.md](../reviews/verification-evidence-http-client-boundary-check-2026-06-09.md)。
- `javax.*` 首轮核对已完成，当前仅剩合法的 `javax.sql.DataSource` 标准 JDBC 用法，未发现需要迁移到 `jakarta.*` 的旧 EE 残留。验证证据见 [docs/reviews/verification-evidence-javax-baseline-check-2026-06-09.md](../reviews/verification-evidence-javax-baseline-check-2026-06-09.md)。
- 对过长 Java 文件和方法做分阶段收口。
- 当前主要阻塞已收敛为基础设施层构建问题：`mvn -B -pl ruoyi-admin,ruoyi-modules/ruoyi-system -am -DskipTests compile` 仍会在 `ruoyi-common-oss` 的 AWS SDK 缺失处失败。后续应单独拆分该阻塞修复，避免边界治理和依赖治理相互缠绕。

## P3：发布与观测

- 修正 GitHub Actions 构建、发布、回滚 workflow。
- 将发布制品路径统一到 `server/ruoyi-admin/target/ruoyi-admin.jar` 或真实构建产物。
- 校验 [deploy/observability](../../deploy/observability) 中的 Actuator 配置是否与代码和部署现实一致。
- 为 SQL 升级脚本补充发布前检查与回滚策略说明。

## P4：Harness 自动化

- 持续完善 Markdown 元数据检查。
- 持续完善 Markdown 相对链接与锚点检查。
- 增加历史事实误用扫描。
- 增加 workflow 路径存在性检查。
- 增加 SQL 变更触发的文档同步提醒。
- 增加新增业务功能时的纵向切片提醒，覆盖后端、前端、SQL、权限、API、测试和验证证据。
- 自动化实施顺序与阻断策略以 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) 为准。
- 各阶段接入说明见 [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)、[docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)、[docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)、[docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 新增业务功能进入迭代前必须先核对 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)。
- 涉及架构或边界变化的任务，必须同步 [docs/architecture/code-map.md](../architecture/code-map.md) 与 [docs/architecture/README.md](../architecture/README.md)。
- 涉及 API 的任务必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 涉及响应码或错误消息的任务必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及 SQL 的任务必须同步 [server/script/sql](../../server/script/sql)、[docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 与发布检查材料。
