---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后台管理功能路线图，围绕当前 RuoYi-Vue-Plus system、monitor、tool、workflow、demo 能力组织。
---

# 后台管理功能路线图

## 目标

本文档替代旧的 Web MVP 路线图，用于描述当前 RuoYi-Vue-Plus 后台管理系统的功能主线、前后端对应关系和后续收敛方向。

## 当前功能域

| 功能域 | 后端入口 | 前端入口 | 说明 |
| --- | --- | --- | --- |
| 认证与登录 | [server/ruoyi-admin/src/main/java/org/dromara/web/controller](../../server/ruoyi-admin/src/main/java/org/dromara/web/controller) | [web/src/api/login.ts](../../web/src/api/login.ts) | 登录、登出、注册、验证码、租户列表、第三方绑定 |
| 系统管理 | [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) | [web/src/views/system](../../web/src/views/system) | 用户、角色、部门、菜单、字典、租户、客户端、OSS、通知 |
| 监控 | [server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor) | [web/src/views/monitor](../../web/src/views/monitor) | 在线用户、登录日志、操作日志、缓存、Admin、SnailJob |
| 代码生成 | [server/ruoyi-modules/ruoyi-generator](../../server/ruoyi-modules/ruoyi-generator) | [web/src/views/tool/gen](../../web/src/views/tool/gen) | 表导入、预览、下载、同步与代码生成 |
| 工作流 | [server/ruoyi-modules/ruoyi-workflow](../../server/ruoyi-modules/ruoyi-workflow) | [web/src/views/workflow](../../web/src/views/workflow) | 流程定义、分类、实例、任务、请假示例 |
| 示例能力 | [server/ruoyi-modules/ruoyi-demo](../../server/ruoyi-modules/ruoyi-demo) | [web/src/views/demo](../../web/src/views/demo) | 缓存、锁、限流、加密、Excel、WebSocket、SSE 等示例 |

## 当前收敛重点

1. 让文档、API、响应码、SQL 脚本和发布材料匹配当前功能域。
2. 清理旧 `ProjectPilot` 项目管理、搜索、计费、CallCenter 路线描述。
3. 修正 `.github/workflows` 中仍指向 `services/callcenter-server` 的历史路径。
4. 将 Harness Engineering 从概念文档收敛为代码地图、检查清单、验证证据和自动化校验。
5. 后续新增功能优先接入现有 `system`、`workflow`、`tool/gen` 等功能域，而不是另起一套不匹配的目录结构。

## 前后端联动规则

新增或修改后台页面时，至少同步检查：

- 后端 Controller、Service、Mapper 和实体位置。
- 前端 [web/src/api](../../web/src/api) 请求封装。
- 前端 [web/src/views](../../web/src/views) 页面和路由。
- 权限标识、菜单配置和 SQL 脚本。
- API 文档和响应码文档。
- 对应评审清单和测试用例。

## 非目标

当前阶段不继续扩张：

- 独立项目管理 MVP 叙事。
- 搜索平台、计费平台、交付平台等未落地业务方向。
- 与当前代码无关的 CallCenter 业务模型。
- 不指向真实目录的 `apps/packages` 前端目标结构。

## 推荐联读

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/boundaries.md](../architecture/boundaries.md)
- [docs/design/feature-auth.md](feature-auth.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/reference/error-codes.md](../reference/error-codes.md)
