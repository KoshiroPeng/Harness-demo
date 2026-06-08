---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 当前代码地图，记录真实目录、模块、入口、依赖和已知历史残留。
---

# 当前代码地图

## 目标

本文档是 HernessDemo 的事实锚点，用于防止文档继续偏离当前代码。凡是架构、设计、评审或发布文档与本文冲突，应先回到真实代码核对。

## 顶层结构

```text
.
├── AGENTS.md
├── README.md
├── docs/
├── server/
├── web/
├── deploy/
├── .github/workflows/
└── services/
```

| 路径 | 当前事实 | 维护要求 |
| --- | --- | --- |
| [server](../../server) | RuoYi-Vue-Plus 后端 Maven 多模块工程 | 后端开发、构建、SQL 脚本以此为准 |
| [web](../../web) | RuoYi-Vue-Plus Vue 3 前端应用 | 前端页面、接口客户端、路由与状态以此为准 |
| [docs](../../docs) | 仓库级协作文档、架构、规范、计划、评审材料 | 必须匹配当前代码事实 |
| [deploy](../../deploy) | 发布、回滚、本地观测支撑材料 | 当前仍有历史命名，需要谨慎核对 |
| [services](../../services) | 历史空目录，仅残留 `target` 等构建痕迹 | 不作为当前源码入口 |

## 后端地图

后端根：[server/pom.xml](../../server/pom.xml)

已确认事实：

- `artifactId` 为 `ruoyi-vue-plus`，版本属性 `revision` 为 `5.6.1`。
- `spring-boot.version` 为 `3.5.14`。
- `java.version` 为 `17`。
- Maven 顶层模块为 `ruoyi-admin`、`ruoyi-common`、`ruoyi-extend`、`ruoyi-modules`。

```text
server/
├── ruoyi-admin/
├── ruoyi-common/
├── ruoyi-modules/
├── ruoyi-extend/
└── script/
```

| 模块 | 主要职责 |
| --- | --- |
| [server/ruoyi-admin](../../server/ruoyi-admin) | Spring Boot 启动入口、认证入口、应用配置、最终打包 Jar |
| [server/ruoyi-common](../../server/ruoyi-common) | 公共基础能力，包含 core、web、mybatis、redis、satoken、tenant、oss、log、excel、sse、websocket 等 |
| [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) | 系统管理主业务，包含用户、角色、部门、菜单、字典、租户、客户端、OSS、通知、日志等 |
| [server/ruoyi-modules/ruoyi-generator](../../server/ruoyi-modules/ruoyi-generator) | 代码生成器 |
| [server/ruoyi-modules/ruoyi-job](../../server/ruoyi-modules/ruoyi-job) | 定时任务客户端能力 |
| [server/ruoyi-modules/ruoyi-workflow](../../server/ruoyi-modules/ruoyi-workflow) | 工作流定义、实例、任务、分类、表达式与请假示例 |
| [server/ruoyi-modules/ruoyi-demo](../../server/ruoyi-modules/ruoyi-demo) | 框架能力示例 |
| [server/ruoyi-extend](../../server/ruoyi-extend) | Spring Boot Admin 与 SnailJob Server 等独立扩展 |
| [server/script](../../server/script) | SQL、Docker Compose、启动脚本和示例流程数据 |

## 后端入口与关键链路

```mermaid
flowchart TD
    Client["前端或 HTTP 客户端"]
    Admin["ruoyi-admin / DromaraApplication"]
    Auth["AuthController / CaptchaController"]
    Common["ruoyi-common-* 横切能力"]
    System["ruoyi-system 系统管理"]
    Generator["ruoyi-generator 代码生成"]
    Workflow["ruoyi-workflow 工作流"]
    Demo["ruoyi-demo 示例"]
    DB["SQL 脚本与数据库"]
    Redis["Redis / Redisson"]

    Client --> Admin
    Admin --> Auth
    Admin --> System
    Admin --> Generator
    Admin --> Workflow
    Admin --> Demo
    Auth --> Common
    System --> Common
    Generator --> Common
    Workflow --> Common
    Demo --> Common
    Common --> DB
    Common --> Redis
```

关键事实：

- 启动类为 [server/ruoyi-admin/src/main/java/org/dromara/DromaraApplication.java](../../server/ruoyi-admin/src/main/java/org/dromara/DromaraApplication.java)。
- 认证入口为 [server/ruoyi-admin/src/main/java/org/dromara/web/controller/AuthController.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/controller/AuthController.java)。
- 统一响应对象为 [server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java)。
- 全局异常处理为 [server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java)。
- i18n 消息读取为 [server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/utils/MessageUtils.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/utils/MessageUtils.java)。

## 前端地图

前端根：[web/package.json](../../web/package.json)

已确认事实：

- 包名为 `ruoyi-vue-plus`。
- 使用 Vue 3、TypeScript、Vite、Element Plus、Pinia、Vue Router、VXE Table。
- 当前没有 `pnpm-lock.yaml`、`package-lock.json` 或 `yarn.lock`，包管理器未由锁文件固定。

```text
web/
├── src/api/
├── src/views/
├── src/router/
├── src/store/
├── src/layout/
├── src/components/
├── src/utils/
└── vite/
```

| 路径 | 主要职责 |
| --- | --- |
| [web/src/api](../../web/src/api) | 前端接口客户端，按 system、monitor、tool、workflow、demo 等能力分组 |
| [web/src/views/system](../../web/src/views/system) | 用户、角色、部门、菜单、租户、客户端、字典、配置、OSS、通知等系统管理页面 |
| [web/src/views/monitor](../../web/src/views/monitor) | 在线用户、登录日志、操作日志、缓存、Admin、SnailJob 等监控页面 |
| [web/src/views/tool/gen](../../web/src/views/tool/gen) | 代码生成器页面 |
| [web/src/views/workflow](../../web/src/views/workflow) | 工作流定义、实例、任务、分类、请假示例等页面 |
| [web/src/store](../../web/src/store) | Pinia 状态模块 |
| [web/src/router](../../web/src/router) | 路由配置 |

## 数据脚本与迁移事实

当前数据库事实入口是 [server/script/sql](../../server/script/sql)，包括：

- `ry_vue_5.X.sql`
- `ry_job.sql`
- `ry_workflow.sql`
- `update/` 版本升级脚本
- `oracle/`、`postgres/`、`sqlserver/` 兼容脚本

当前仓库没有 Flyway 目录或 Flyway Maven 依赖。后续如果引入 Flyway，必须作为单独迁移任务处理，并同步修改 [docs/architecture/target-technology-baseline.md](target-technology-baseline.md)、[docs/architecture/data-flow.md](data-flow.md) 和 [deploy/release/README.md](../../deploy/release/README.md)。

## 已知历史残留

- [services](../../services) 目录当前没有源码文件，只剩空目录或构建残留，不能作为真实服务入口。
- [.github/workflows](../../.github/workflows) 中部分 workflow 仍引用 `services/callcenter-server`，当前与代码事实不匹配。
- [deploy/release](../../deploy/release) 中部分脚本默认服务名或目录仍使用 `herness-demo`，需要在真实发布前统一。
- [server/README.md](../../server/README.md) 和 [web/README.md](../../web/README.md) 保留上游 RuoYi-Vue-Plus 说明，可作为脚手架参考，但仓库级约束以 [AGENTS.md](../../AGENTS.md) 和 [docs/README.md](../README.md) 为准。

## 维护规则

- 任何架构文档更新前，先核对本文与真实代码。
- 新增或删除后端模块、前端目录、发布入口、workflow 时，同步更新本文。
- 如果发现旧文档声称与本文冲突，优先修旧文档，不要复制旧说法。
