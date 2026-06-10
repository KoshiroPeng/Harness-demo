# HarnessBase

HarnessBase 是一个基于若依微服务体系整理的后台管理系统工程基座。当前仓库已经落地为“后端微服务 + Vue 2 管理后台 + 发布与观测支撑 + 协作文档”的完整结构，适合作为持续开发、评审、发布和治理的统一入口。

## 当前仓库事实

- 后端工程位于 [server](server)，采用 Maven 多模块结构，当前主线模块包括网关、认证、系统、代码生成、定时任务、文件服务和监控服务。
- 前端工程位于 [web](web)，采用 Vue 2、Vue CLI、Element UI、Vuex、Vue Router 3，当前主语言为 JavaScript。
- 发布、回滚、远端初始化与观测材料位于 [deploy](deploy) 与 [.github](.github)。
- 当前仓库同时支持“模块级 SSH 发布”和“整套微服务 docker-compose 编排部署”两条交付路径。
- 仓库级协作规则、架构边界、代码地图、评审模板和验证证据入口位于 [docs](docs)。

## 顶层目录

```text
.
├── AGENTS.md
├── README.md
├── .github/
├── deploy/
├── docs/
├── scripts/
├── server/
└── web/
```

| 路径 | 当前用途 |
| --- | --- |
| [AGENTS.md](AGENTS.md) | 仓库唯一 AI 协作规则入口 |
| [docs](docs) | 架构、规范、计划、评审、参考资料 |
| [server](server) | 若依微服务后端工程 |
| [web](web) | Vue 2 管理后台前端工程 |
| [deploy](deploy) | 发布、回滚、观测支撑材料 |
| [.github](.github) | GitHub Actions workflow 与自动化护栏脚本入口 |
| [scripts](scripts) | 仓库级辅助脚本预留目录 |

## 后端概览

后端 Maven 根为 [server/pom.xml](server/pom.xml)，当前关键事实如下：

- `groupId`：`com.ruoyi`
- `artifactId`：`ruoyi`
- `version`：`3.6.8`
- `java.version`：`17`
- `spring-boot.version`：`4.0.3`
- `spring-cloud.version`：`2025.1.0`
- `spring-cloud-alibaba.version`：`2025.1.0.0`

| 模块 | 说明 |
| --- | --- |
| [server/ruoyi-gateway](server/ruoyi-gateway) | 微服务统一入口、路由与网关过滤 |
| [server/ruoyi-auth](server/ruoyi-auth) | 登录认证、鉴权与认证链路 |
| [server/ruoyi-modules/ruoyi-system](server/ruoyi-modules/ruoyi-system) | 系统管理主业务 |
| [server/ruoyi-modules/ruoyi-gen](server/ruoyi-modules/ruoyi-gen) | 代码生成服务 |
| [server/ruoyi-modules/ruoyi-job](server/ruoyi-modules/ruoyi-job) | 定时任务服务 |
| [server/ruoyi-modules/ruoyi-file](server/ruoyi-modules/ruoyi-file) | 文件服务 |
| [server/ruoyi-visual/ruoyi-monitor](server/ruoyi-visual/ruoyi-monitor) | 监控服务 |
| [server/ruoyi-api](server/ruoyi-api) | 服务间远程接口定义与共享模型 |
| [server/ruoyi-common](server/ruoyi-common) | 公共能力模块 |
| [server/sql](server/sql) | 当前数据库脚本事实目录 |

当前仓库已存在的 SQL 脚本包括：

- [server/sql/quartz.sql](server/sql/quartz.sql)
- [server/sql/ry_20260321.sql](server/sql/ry_20260321.sql)
- [server/sql/ry_config_20260311.sql](server/sql/ry_config_20260311.sql)
- [server/sql/ry_seata_20210128.sql](server/sql/ry_seata_20210128.sql)

## 前端概览

前端包配置入口为 [web/package.json](web/package.json)，当前关键事实如下：

- 包名：`ruoyi`
- 版本：`3.6.8`
- 构建工具：Vue CLI 4
- UI 组件库：Element UI `2.15.14`
- 核心依赖：Vue `2.6.12`、Vue Router `3.4.9`、Vuex `3.6.0`

| 目录 | 说明 |
| --- | --- |
| [web/src/api](web/src/api) | 前端接口请求封装 |
| [web/src/views/system](web/src/views/system) | 系统管理页面 |
| [web/src/views/monitor](web/src/views/monitor) | 监控页面 |
| [web/src/views/tool](web/src/views/tool) | 工具页面 |
| [web/src/router](web/src/router) | 路由入口 |
| [web/src/store](web/src/store) | Vuex 状态管理 |
| [web/src/layout](web/src/layout) | 全局布局 |
| [web/src/components](web/src/components) | 通用组件 |

## 常用命令

后端构建与测试：

```bash
cd server
mvn -B -DskipTests package
mvn -B test
```

前端安装、开发与构建：

```bash
cd web
npm install
npm run dev
npm run build:stage
npm run build:prod
```

本地观测环境：

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

整套微服务 `docker-compose` 部署：

```bash
bash deploy/compose/build-compose-artifacts.sh
bash deploy/compose/manage-compose.sh up-all
```

## 协作入口

| 你现在要做什么 | 建议先看 |
| --- | --- |
| 了解仓库协作规则 | [AGENTS.md](AGENTS.md) |
| 了解文档导航总入口 | [docs/README.md](docs/README.md) |
| 找真实代码落位 | [docs/architecture/code-map.md](docs/architecture/code-map.md) |
| 看系统结构与技术基线 | [docs/architecture/overview.md](docs/architecture/overview.md)、[docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) |
| 开发后端 | [server/README.md](server/README.md)、[docs/conventions/task-startup-checklist.md#开发后端代码](docs/conventions/task-startup-checklist.md#开发后端代码) |
| 开发前端 | [web/README.md](web/README.md)、[docs/conventions/task-startup-checklist.md#开发前端代码](docs/conventions/task-startup-checklist.md#开发前端代码) |
| 调整接口、响应码或 SQL | [docs/reference/README.md](docs/reference/README.md) |
| 做评审与记录验证证据 | [docs/reviews/README.md](docs/reviews/README.md) |
| 看 workflow、发布或回滚 | [.github/README.md](.github/README.md)、[deploy/release/README.md](deploy/release/README.md)、[deploy/compose/README.md](deploy/compose/README.md) |

## 建议阅读顺序

1. [AGENTS.md](AGENTS.md)
2. [docs/README.md](docs/README.md)
3. [docs/architecture/code-map.md](docs/architecture/code-map.md)
4. [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)
5. [server/README.md](server/README.md) 或 [web/README.md](web/README.md)

## 维护说明

- 根目录 `README.md` 负责作为仓库对外总入口，内容应以真实代码与真实目录为准。
- 如果新增或删除顶层目录、核心模块、启动方式、发布入口或关键文档入口，必须同步更新本文档。
- 如果本文档与 [docs/architecture/code-map.md](docs/architecture/code-map.md) 或真实代码结构冲突，优先回到代码核对后再修正文档。
