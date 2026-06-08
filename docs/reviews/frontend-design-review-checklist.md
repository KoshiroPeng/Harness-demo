---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 前端设计评审清单，用于检查交互设计、接口调用、路由权限与前端业务逻辑设计。
---

# 前端设计评审清单

## 评审重点

1. 交互设计
2. 接口调用设计
3. 前端业务逻辑设计

## 适用范围

- `web/` 前端应用启用后的详细设计评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 是否按模板要求编写详细设计说明书？ |
| 必选 | 2 | 是否有路由设计，路由设计是否合理？ |
| 必选 | 3 | 路由命名是否符合规范，是否会和已存在路由冲突？ |
| 必选 | 4 | 是否有出入口设计，出入口是否合理？ |
| 必选 | 5 | 是否有组件设计，是否可以复用已有组件，复用是否影响原有功能？ |
| 必选 | 6 | 是否有交互设计，是否符合业务使用场景？ |
| 必选 | 7 | 表单交互设计是否体现验证条件？ |
| 必选 | 8 | 是否考虑字符异常长度、敏感操作二次确认等交互保护？ |
| 必选 | 9 | 是否有调用接口说明，是否体现关键参数和接口异常提示？ |
| 必选 | 10 | 前端是否有业务处理逻辑，处理逻辑是否合理？ |
| 必选 | 11 | 接口返回数据使用是否方便，是否存在一个操作需要调用多个接口？ |
| 必选 | 12 | 若存在前端缓存，是否有保证数据一致性的设计？ |
| 必选 | 13 | 若使用外部接口，是否有参数保障设计和异常提示设计？ |
| 必选 | 14 | 是否复用已存在方法，复用是否影响原有功能？ |
| 必选 | 15 | 设计是否服务当前后台管理功能域，而不是超前扩张前端平台能力？ |

## 当前项目适配说明

- 当前仓库已经存在 `web/` Vue 3 应用，本清单按 [web/src/api](../../web/src/api)、[web/src/views](../../web/src/views)、[web/src/router](../../web/src/router)、[web/src/store](../../web/src/store) 的真实结构执行。
- 前端设计应优先围绕 system、monitor、tool/gen、workflow、demo 等现有功能域收敛。
- 若设计讨论中引用 Harness Engineering，应优先确认它是在帮助前端主链路交付，而不是扩张通用平台层。

## 配套入口

- [docs/reviews/templates/frontend-design-review-template.md](templates/frontend-design-review-template.md)
- [docs/design/backend-admin-roadmap.md](../design/backend-admin-roadmap.md)
- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)
