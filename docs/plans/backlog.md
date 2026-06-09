---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 当前阶段的持续治理待办，覆盖微服务结构纠偏、文档同步、质量护栏、发布路径和自动化接入收口。
---

# Backlog

## P0：真实结构护栏

- 持续防止 `.github/workflows` 回退引用旧目录、旧服务名或错误制品路径。
- 持续清理活跃文档中对旧单体结构、旧包名、旧 SQL 路径和旧前端技术栈的误用传播。
- 统一“仓库名、服务名、制品名、部署名”的命名语境，避免把历史名称混写成当前业务名称。

## P1：文档事实同步

- 基于 [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md) 持续沉淀当前微服务项目的纵向切片模板。
- 持续校准 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)，确保与真实 Controller、网关入口和 [web/src/api](../../web/src/api) 保持一致。
- 持续维护 [docs/reference/error-codes.md](../reference/error-codes.md)，确保其与 `R`、`TableDataInfo`、异常处理器和 i18n 事实对齐。
- 持续维护 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)，确保其与 [server/sql](../../server/sql) 脚本体系一致。
- 如果再次发现前后端接口漂移，先在 [docs/reference/README.md](../reference/README.md) 记录事实，再按 [docs/plans/frontend-backend-api-drift-fix-brief.md](frontend-backend-api-drift-fix-brief.md) 拆分修复任务。

## P2：代码与质量硬化

- 按风险补齐后端单元测试和集成测试。
- 结合当前前端工具链，补齐适合 Vue 2 / JavaScript 项目的前端测试基线说明和最小覆盖策略。
- 持续扫描直接跨层调用、绕过公共契约或绕过服务边界的实现。
- 持续收敛过长文件、过长方法、重复逻辑和日志输出不规范问题。

## P3：发布与运维入口

- 校准 GitHub Actions 中的构建、发布、回滚路径，使其与当前微服务结构一致。
- 核对发布材料中涉及的服务清单、启动顺序、回滚口径和 SQL 执行说明。
- 核对 [deploy/observability](../../deploy/observability) 中的内容是否与当前网关、认证、监控和业务服务结构一致。

## P4：Harness 自动化接入

- 维护已接入的 A01 Markdown 元数据检查。
- 维护已接入的 A02 Markdown 相对链接与锚点检查。
- 维护已并入 A02 的 A03 已删除文档引用检查。
- 维护已接入的 A04 历史事实误用扫描，持续校准命中词和忽略语境。
- 维护已接入的 A05 workflow 路径存在性检查，持续覆盖 `working-directory`、`cache-dependency-path`、构建产物、发布脚本和模板路径。
- 增加 A06-A08 SQL、API、错误码和发布材料的同步提醒。
- 自动化实施顺序与阻断策略以 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md) 为准。
- 各阶段入口见：
  - [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)
  - [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)
  - [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)
  - [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)

## 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及架构或边界变化的任务，必须同步 [docs/architecture/code-map.md](../architecture/code-map.md) 和相关入口文档。
- 涉及 API 的任务，必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或明确说明由运行时文档覆盖。
- 涉及错误码、异常处理或 i18n 的任务，必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及 SQL 的任务，必须同步 [server/sql](../../server/sql)、[docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 与相关发布材料。
