---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 一页开发执行手册，压缩说明开发前阅读、开发中同步检查和提交前自检的最短路径。
---

# 一页开发执行手册

## 目标

本文档不是替代详细规范，而是给真实开发、评审、补测试和文档同步时提供一条最短执行路径。

如果你现在只想快速判断“先看什么、改的时候盯什么、结束前查什么”，先看本文；如果需要展开细节，再跳到对应详细文档。

## 什么时候先看本文

- 刚接手一个任务，还没判断要先读哪些文档。
- 已经知道要改代码，但不确定还要同步哪些说明材料。
- 准备提交代码前，想快速做一次最小自检。

## 第一步：开始前先读什么

固定起步顺序：

1. [AGENTS.md](../../AGENTS.md)
2. [docs/README.md](../README.md)
3. [docs/architecture/code-map.md](../architecture/code-map.md)
4. [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)

然后按任务类型补读：

| 任务类型 | 至少补读这些文档 |
| --- | --- |
| 后端开发 | [docs/architecture/business-extension-baseline.md](../architecture/business-extension-baseline.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md)、[docs/reviews/backend-code-review-checklist.md](../reviews/backend-code-review-checklist.md) |
| 前端开发 | [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)、[docs/reviews/frontend-code-review-checklist.md](../reviews/frontend-code-review-checklist.md) |
| 新增业务功能 | [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)、[docs/reviews/backend-design-review-checklist.md](../reviews/backend-design-review-checklist.md)、[docs/reviews/frontend-design-review-checklist.md](../reviews/frontend-design-review-checklist.md) |
| SQL 变更 | [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md) |
| 发布或 workflow 变更 | [deploy/release/README.md](../../deploy/release/README.md)、[.github/README.md](../../.github/README.md) |
| 评审或自检 | [docs/conventions/task-startup-checklist.md](task-startup-checklist.md)、[docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) |

停止继续追导航的条件：

- 已经明确要改哪些目录或文件。
- 已经明确是否涉及 API、SQL、权限、测试、发布或文档同步。
- 已经明确本次验证方式和未覆盖风险记录位置。

## 第二步：改动时重点盯什么

先用 [docs/conventions/change-trigger-matrix.md](change-trigger-matrix.md) 判断这次改动会触发哪些文档同步要求。

最常见的同步检查如下：

| 如果你改了 | 至少同步确认 |
| --- | --- |
| 后端 Controller / 接口 | [docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/reference/README.md](../reference/README.md) |
| 前端 `web/src/api` | 前后端契约是否一致，必要时登记已知差异 |
| 响应码、异常处理、i18n | [docs/reference/error-codes.md](../reference/error-codes.md) |
| SQL 脚本 | [server/script/sql](../../server/script/sql)、[deploy/release/release-checklist.md](../../deploy/release/release-checklist.md) |
| 模块边界或目录结构 | [docs/architecture/code-map.md](../architecture/code-map.md)、[docs/architecture/boundaries.md](../architecture/boundaries.md) |
| 发布、回滚、workflow | [deploy/release/README.md](../../deploy/release/README.md)、[.github/README.md](../../.github/README.md) |

开发中的硬性提醒：

- 不要新增 `javax.*`、字段级 `@Autowired`、`System.out.println`、`e.printStackTrace()`。
- 涉及中文内容的文件保持 UTF-8。
- 新增业务代码必须补测试；缺陷修复必须补回归测试。
- 不要只改代码不改导航文档；任何影响主路径的文档变更都要回写入口页。

## 第三步：提交前怎么自检

提交前至少确认下面 8 件事：

1. 代码改动已经落在真实模块边界内，没有绕开现有结构。
2. API、错误码、SQL、发布材料等被触发的文档已经同步。
3. 本次变更对应的测试已补齐，或明确记录了为什么暂时不能补。
4. 涉及风险的验证结果已经记录到 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 或等价材料。
5. 新增或修改的治理型 Markdown 已补齐标头，且更新了 `last_updated`。
6. 导航页里的新增链接可以直接点击到目标文档。
7. `git status` 已确认工作区状态正确。
8. 提交信息、PR 说明、评审结论和新增中文注释均使用简体中文。

## 详细入口

如果本文已经不够用，再按下面顺序展开：

1. [docs/conventions/task-startup-checklist.md](task-startup-checklist.md)
2. [docs/conventions/change-trigger-matrix.md](change-trigger-matrix.md)
3. [docs/reviews/README.md](../reviews/README.md)
4. [docs/reference/README.md](../reference/README.md)
5. [deploy/release/README.md](../../deploy/release/README.md)

## 一句话准则

先看代码地图，再按任务读最少必需文档；改动时用触发矩阵补同步；提交前用 8 项自检收口。
