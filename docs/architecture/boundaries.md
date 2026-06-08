---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 模块边界和依赖规则，约束 RuoYi-Vue-Plus 多模块结构下的扩展方式。
---

# 模块边界和依赖规则

## 目标

本文档约束 HernessDemo 在当前 RuoYi-Vue-Plus 多模块结构下如何继续扩展，避免文档写一套、代码走另一套。

## 当前模块边界

```text
ruoyi-admin
  -> ruoyi-modules/*
  -> ruoyi-common/*
ruoyi-modules/*
  -> ruoyi-common/*
ruoyi-extend/*
  -> 按独立服务或运维扩展管理
web/src/views
  -> web/src/api
  -> 后端 HTTP API
```

| 层级 | 当前路径 | 主要职责 |
| --- | --- | --- |
| 启动聚合 | [server/ruoyi-admin](../../server/ruoyi-admin) | 启动类、Web 服务入口、认证控制器、应用配置、最终 Jar |
| 公共能力 | [server/ruoyi-common](../../server/ruoyi-common) | core、web、mybatis、redis、satoken、tenant、security、oss、log、excel、sse、websocket 等 |
| 业务模块 | [server/ruoyi-modules](../../server/ruoyi-modules) | system、generator、job、workflow、demo |
| 运维扩展 | [server/ruoyi-extend](../../server/ruoyi-extend) | monitor admin、SnailJob server |
| 前端接口 | [web/src/api](../../web/src/api) | 按功能域封装接口请求与类型 |
| 前端页面 | [web/src/views](../../web/src/views) | 按 system、monitor、tool、workflow、demo 等功能域组织页面 |

## 新增后端能力放置规则

- 新增后台管理业务能力，优先评估是否属于 `ruoyi-system`。
- 新增代码生成能力，优先放入 `ruoyi-generator`。
- 新增工作流能力，优先放入 `ruoyi-workflow`。
- 新增任务调度客户端能力，优先放入 `ruoyi-job` 或对应 common job 能力。
- 新增通用基础设施能力，优先放入对应 `ruoyi-common-*`；没有合适模块时再新增 common 子模块。
- 新增独立运行的运维服务，才考虑 `ruoyi-extend`。
- `ruoyi-admin` 只做启动、装配、配置和少量 Web 入口聚合，不承载大段业务规则。

## 新增前端能力放置规则

- API 请求封装放在 [web/src/api](../../web/src/api) 对应功能域下。
- 页面放在 [web/src/views](../../web/src/views) 对应功能域下。
- 跨页面共享组件放在 [web/src/components](../../web/src/components)。
- 路由接入按现有 [web/src/router](../../web/src/router) 模式处理。
- 状态管理按现有 [web/src/store](../../web/src/store) Pinia 模块处理。

## 禁止事项

- 禁止把不存在的 `bootstrap/shared/modules` 目标结构当成当前落地事实。
- 禁止新增业务绕过 Service，直接在 Controller 中堆叠复杂规则。
- 禁止跨模块直接调用其他模块 Controller。
- 禁止业务代码直接散落第三方 SDK 初始化逻辑；应进入 common、adapter 或明确封装类。
- 禁止新增 `javax.*` 命名空间。
- 禁止新增字段级 `@Autowired`。

## 数据边界

- 当前数据库结构由 [server/script/sql](../../server/script/sql) 维护。
- 表结构调整必须同步初始化 SQL 与升级 SQL。
- Mapper、实体和 XML 不能替代数据库脚本。
- 多数据源能力通过 dynamic-datasource 和既有配置接入，不能在业务代码中临时创建裸数据源。

## 新增模块检查清单

新增模块前必须确认：

- 是否已有 `ruoyi-common-*` 或 `ruoyi-modules/*` 能承载该能力。
- 是否需要同步前端 `web/src/api` 与 `web/src/views`。
- 是否需要同步 SQL 脚本、API 文档、响应码文档和测试。
- 是否会影响 [docs/architecture/code-map.md](code-map.md)。
