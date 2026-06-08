---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 前端代码评审清单，用于检查代码规范、结构合理性与前端逻辑安全性。
---

# 前端代码评审清单

## 评审重点

1. 代码规范
2. 程序结构合理性
3. 逻辑正确性与安全性

## 适用范围

- `web/` 前端应用启用后的代码评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 变量、常量、方法名命名是否符合规范？ |
| 必选 | 2 | 类、方法、关键逻辑是否有适当注释？ |
| 必选 | 3 | 是否对表单内容和接口返回结果做了合理校验？ |
| 必选 | 4 | 是否对可能出现异常的逻辑做了合理处理，界面提示是否合理？ |
| 必选 | 5 | 循环是否一定能结束，判断条件是否合理？ |
| 必选 | 6 | 定时器是否一定能停止，是否存在频繁接口请求？ |
| 必选 | 7 | 是否存在单个方法过于繁琐，是否可以提取公共逻辑？ |
| 必选 | 8 | 若使用第三方工具类，是否评估过并发与稳定性问题？ |
| 必选 | 9 | 接口调用是否合理，是否考虑减少不必要调用？ |
| 必选 | 10 | 是否评估接口返回的最大数据量，DOM 操作是否有性能问题？ |
| 必选 | 11 | 若调整公共组件，是否评估影响范围？ |
| 必选 | 12 | 事件监听是否有销毁，是否会影响其他组件？ |
| 必选 | 13 | 是否为了“工程化”引入了与当前阶段不匹配的前端平台抽象？ |

## 当前项目适配说明

- 当前仓库已经存在 `web/` Vue 3 应用，本清单应按 Vue 3、TypeScript、Vite、Element Plus、Pinia 与现有目录边界执行。
- 若改动涉及 `web/src/api`、`web/src/views`、路由、store 或公共组件，必须评估影响范围并同步更新相关设计文档。

## 配套入口

- [docs/reviews/templates/frontend-code-review-template.md](templates/frontend-code-review-template.md)
- [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)
- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)
