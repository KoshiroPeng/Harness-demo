---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 任务启动清单，帮助开发、评审、测试、发布和文档治理任务快速找到联读文档。
---

# 任务启动清单

## 目标

本文档提供“开始做事前先读什么、动手后要补什么、结束前怎么自检”的最小启动路径。

## 通用起步顺序

无论当前任务是什么，建议先完成下面步骤：

1. 阅读 [AGENTS.md](../../AGENTS.md)
2. 阅读 [docs/README.md](../README.md)
3. 阅读 [docs/architecture/code-map.md](../architecture/code-map.md)
4. 阅读 [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
5. 根据任务类型跳到下方对应清单

## 开发后端代码

开始前建议依次阅读：

1. [docs/architecture/boundaries.md](../architecture/boundaries.md)
2. [docs/architecture/data-flow.md](../architecture/data-flow.md)
3. [docs/conventions/README.md](README.md)
4. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
5. [docs/conventions/testing.md](testing.md)

动手时重点确认：

- 当前改动属于 `ruoyi-admin`、`ruoyi-common-*`、`ruoyi-modules/*` 还是 `ruoyi-extend/*`。
- 是否涉及 API、响应码、SQL 脚本、菜单权限或发布影响。
- 是否新增 `javax.*`、字段级 `@Autowired`、`System.out.println` 或 `e.printStackTrace()`。
- 是否需要同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或 [docs/reference/error-codes.md](../reference/error-codes.md)。

## 开发前端代码

开始前建议依次阅读：

1. [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)
2. [docs/conventions/README.md](README.md)
3. [docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md)
4. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
5. [docs/conventions/testing.md](testing.md)

动手时重点确认：

- API 封装是否放在 [web/src/api](../../web/src/api) 对应功能域。
- 页面是否放在 [web/src/views](../../web/src/views) 对应功能域。
- 路由、权限、store 和后端菜单配置是否同步。

## 数据库脚本变更

开始前建议依次阅读：

1. [docs/architecture/data-flow.md](../architecture/data-flow.md)
2. [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
3. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)

动手时重点确认：

- 当前变更是否更新初始化 SQL。
- 当前变更是否需要新增或修改 [server/script/sql/update](../../server/script/sql/update)。
- 是否影响多数据库兼容脚本。
- 是否影响发布、回滚或数据修复说明。

## 做需求或设计评审

开始前建议依次阅读：

1. [docs/design/README.md](../design/README.md)
2. [docs/reviews/requirement-review-checklist.md](../reviews/requirement-review-checklist.md)
3. [docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)
4. [docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md)

输出结果时建议配合：

- [docs/reviews/templates/requirement-review-template.md](../reviews/templates/requirement-review-template.md)
- [docs/reviews/templates/backend-design-review-template.md](../reviews/templates/backend-design-review-template.md)
- [docs/reviews/templates/frontend-design-review-template.md](../reviews/templates/frontend-design-review-template.md)

## 做代码评审或开发后自检

开始前建议依次阅读：

1. [docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md)
2. [docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md)
3. [docs/conventions/naming.md](naming.md)
4. [docs/conventions/error-handling.md](error-handling.md)
5. [docs/conventions/logging.md](logging.md)
6. [docs/conventions/testing.md](testing.md)

输出结果时建议配合：

- [docs/reviews/templates/backend-code-review-template.md](../reviews/templates/backend-code-review-template.md)
- [docs/reviews/templates/frontend-code-review-template.md](../reviews/templates/frontend-code-review-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 做测试设计、补测试或测试用例评审

开始前建议依次阅读：

1. [docs/conventions/testing.md](testing.md)
2. [docs/reviews/testcase-review-checklist.md](../reviews/testcase-review-checklist.md)
3. [docs/reference/error-codes.md](../reference/error-codes.md)

输出结果时建议配合：

- [docs/reviews/templates/testcase-review-template.md](../reviews/templates/testcase-review-template.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 做发布、回滚或上线验证

开始前建议依次阅读：

1. [deploy/release/README.md](../../deploy/release/README.md)
2. [deploy/release/environment-variable-template.md](../../deploy/release/environment-variable-template.md)
3. [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
4. [deploy/observability/README.md](../../deploy/observability/README.md)

执行前重点确认：

- workflow 是否仍引用历史 `services/callcenter-server` 路径。
- 制品路径是否与 [server/ruoyi-admin](../../server/ruoyi-admin) 实际构建产物一致。
- API、响应码、SQL 和环境变量是否已同步。

## 一句话准则

先看代码地图，再按任务类型联读对应规范、设计、评审和验证材料。
