---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 后续待办列表，覆盖业务扩展基线、文档代码对齐、workflow 修正、SQL 治理、发布支撑与 Harness 自动化。
---

# Backlog

## P0：历史残留清理

- 持续防止 `.github/workflows` 回退到旧源码路径。
- 统一发布脚本中的 `harness-base`、`ruoyi-admin` 服务名和制品名语境。
- 持续扫描并清理文档中残留的历史过渡产品、搜索、计费和旧行业业务事实误用。

## P1：文档事实同步

- 基于 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md) 持续把后续业务开发沉淀为可复用的纵向切片模板。
- 文档治理主线已完成；后续仅在实际开发任务触发时，基于 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) 按需拆分更细的 system、monitor、tool/gen、workflow、demo 子域设计。
- 持续校准 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)，确保仓库级 API 摘要与 SpringDoc、真实 Controller 和前端 [web/src/api](../../web/src/api) 保持一致。
- 持续维护 [docs/reference/error-codes.md](../reference/error-codes.md)，确保它与当前 `R`、`TableDataInfo`、`HttpStatus`、i18n 消息、`GlobalExceptionHandler`、`SaTokenExceptionHandler` 对齐。
- 持续维护 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)，确保 SQL 变更模板和验证清单跟当前脚本体系一致。
- 如果后续再次发现前后端接口漂移，先在 [docs/reference/README.md](../reference/README.md) 记录事实，再按 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) 拆分修复任务。

## P2：代码与质量硬化

- 修复或标记历史启动输出中的 `System.out.println`，避免与新增代码规则冲突。
- 按风险补齐后端单元测试和前端 Vitest 覆盖。
- 检查字段级 `@Autowired`、`javax.*`、裸 HTTP 客户端和直接跨层调用。
- 对过长 Java 文件和方法做分阶段收敛。

## P3：发布与观测

- 修正 GitHub Actions 构建、发布、回滚 workflow。
- 将发布制品路径统一到 `server/ruoyi-admin/target/ruoyi-admin.jar` 或实际构建产物。
- 校验 [deploy/observability](../../deploy/observability) 与 Actuator 配置是否匹配。
- 为 SQL 升级脚本补充发布前检查和回滚策略说明。

## P4：Harness 自动化

- 增加 Markdown 元数据检查。
- 增加 Markdown 链接检查。
- 增加历史事实误用扫描。
- 增加 workflow 路径存在性检查。
- 增加 SQL 变更触发文档同步提醒。
- 增加新增业务功能时的纵向切片检查，提醒同步后端、前端、SQL、权限、API、测试和验证证据。
- 自动化实施顺序与阻断策略以 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) 为准。
- 各阶段接入说明见 [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)、[docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)、[docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)、[docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 新增业务功能进入迭代前必须先核对 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)。
- 涉及架构或边界变化的任务必须同步 [docs/architecture/code-map.md](../architecture/code-map.md) 与 [docs/architecture/README.md](../architecture/README.md)。
- 涉及 API 的任务必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 涉及响应码或错误消息的任务必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及 SQL 的任务必须同步 [server/script/sql](../../server/script/sql)、[docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 与发布检查材料。
