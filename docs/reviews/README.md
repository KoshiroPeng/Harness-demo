---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 评审清单目录入口，汇总需求、设计、代码、测试与验证证据的统一检查入口。
---

# 评审清单总览

## 目标

本目录沉淀 HarnessBase 在需求、设计、代码和测试阶段的评审清单。评审重点是确认变更是否匹配当前若依微服务代码事实、服务边界、SQL 脚本、API 摘要和发布支撑材料。

## 使用原则

- 需求评审使用需求评审清单。
- 后台详细设计评审使用后台设计评审清单。
- 前端详细设计评审使用前端设计评审清单。
- 后台代码评审使用后台代码评审清单。
- 前端代码评审使用前端代码评审清单。
- 测试用例评审使用测试用例评审清单。
- 输出评审结论时，优先使用 [docs/reviews/templates/README.md](templates/README.md)。
- 沉淀验证证据时，优先使用 [docs/reviews/templates/verification-evidence-template.md](templates/verification-evidence-template.md)。
- 评审前若还不清楚模块落位，先回看 [docs/architecture/code-map.md](../architecture/code-map.md)、[server/README.md](../../server/README.md) 或 [web/README.md](../../web/README.md)。

## 与现有文档的关系

- 当前代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)
- 技术基线：[docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- 模块边界：[docs/architecture/boundaries.md](../architecture/boundaries.md)
- Harness Engineering 落地说明：[docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)
- 后台功能域图谱：[docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- 命名规范：[docs/conventions/naming.md](../conventions/naming.md)
- 错误处理：[docs/conventions/error-handling.md](../conventions/error-handling.md)
- 测试规范：[docs/conventions/testing.md](../conventions/testing.md)
- 发布与回滚材料：[deploy/release/README.md](../../deploy/release/README.md)

## 目录索引

| 阶段 | 文档 |
| --- | --- |
| 需求评审 | [docs/reviews/requirement-review-checklist.md](requirement-review-checklist.md) |
| 后台设计评审 | [docs/reviews/backend-design-review-checklist.md](backend-design-review-checklist.md) |
| 前端设计评审 | [docs/reviews/frontend-design-review-checklist.md](frontend-design-review-checklist.md) |
| 后台代码评审 | [docs/reviews/backend-code-review-checklist.md](backend-code-review-checklist.md) |
| 前端代码评审 | [docs/reviews/frontend-code-review-checklist.md](frontend-code-review-checklist.md) |
| 测试用例评审 | [docs/reviews/testcase-review-checklist.md](testcase-review-checklist.md) |
| 评审输出模板 | [docs/reviews/templates/README.md](templates/README.md) |
| 验证证据模板 | [docs/reviews/templates/verification-evidence-template.md](templates/verification-evidence-template.md) |
| A04 自动化试运行记录 | [docs/reviews/automation-a04-history-scan-pilot.md](automation-a04-history-scan-pilot.md) |

## 当前项目适配说明

- 后端评审应围绕 `ruoyi-gateway`、`ruoyi-auth`、`ruoyi-api-*`、`ruoyi-common-*`、`ruoyi-modules/*`、`ruoyi-visual/*` 的真实边界。
- 前端评审应围绕 `web/src/api`、`web/src/views`、`web/src/router`、`web/src/store` 的真实结构。
- 数据库变更必须检查 [server/sql](../../server/sql)，不能假定 Flyway 已落地。
- 涉及 workflow、发布或回滚时，必须检查是否仍指向当前 `server/`、`web/`、`deploy/` 路径。

## 维护规则

- 新增评审阶段时，在本目录补充对应清单。
- 若项目已有规范已经覆盖某项检查，评审清单应引用规范而不是重复定义。
- 若评审中反复暴露同一问题，应考虑把该项上升为强制规范或自动化检查。
