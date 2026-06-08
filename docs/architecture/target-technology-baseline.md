---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 技术基线文档，记录当前 RuoYi-Vue-Plus 后端、前端、数据库脚本和部署支撑事实。
---

# 技术基线

## 目标

本文档记录 HernessDemo 当前已经落地的技术基线，以及后续新增代码和文档必须遵守的约束。它不是迁移设想，而是以当前 [server/pom.xml](../../server/pom.xml) 和 [web/package.json](../../web/package.json) 为事实来源。

## 后端基线

| 类别 | 当前事实 |
| --- | --- |
| 工程基座 | RuoYi-Vue-Plus 5.6.1 |
| Java | JDK 17 |
| 框架 | Spring Boot 3.5.x / Spring Framework 6 |
| 构建 | Maven 多模块 |
| Web 容器 | Undertow |
| 认证授权 | Sa-Token、JWT、JustAuth |
| 持久化 | MyBatis-Plus Boot 3、dynamic-datasource、p6spy |
| 数据库驱动 | 默认 MySQL，脚本保留 Oracle、PostgreSQL、SQL Server 版本 |
| 缓存与锁 | Redis、Redisson、Lock4j |
| 任务调度 | SnailJob |
| 工作流 | Warm Flow |
| 接口文档 | SpringDoc |
| 观测 | Actuator、Spring Boot Admin，部署侧提供 Prometheus/Grafana/Loki 本地材料 |

## 前端基线

| 类别 | 当前事实 |
| --- | --- |
| 工程基座 | RuoYi-Vue-Plus 前端 |
| 框架 | Vue 3 |
| 语言 | TypeScript |
| 构建 | Vite |
| UI | Element Plus |
| 状态 | Pinia |
| 路由 | Vue Router |
| 表格 | VXE Table |
| 样式与工具 | Sass、UnoCSS、Prettier、ESLint |
| 测试 | Vitest |
| Node 要求 | `>=20.19.0` |

当前没有锁文件固定包管理器。新增文档或脚本不要假定已经使用 `pnpm`，除非本次任务同步引入锁文件和验证命令。

## 数据库基线

当前数据库结构由 SQL 脚本维护：

- 初始化脚本：[server/script/sql](../../server/script/sql)。
- 升级脚本：[server/script/sql/update](../../server/script/sql/update)。
- Docker 数据库编排：[server/script/docker/database.yml](../../server/script/docker/database.yml)。

当前没有 Flyway 依赖或 migration 目录。数据库变更默认要求：

1. 更新对应初始化 SQL。
2. 更新对应版本升级 SQL。
3. 如影响发布或回滚，同步更新 [deploy/release/README.md](../../deploy/release/README.md) 或 [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)。
4. 如影响实体、Mapper、接口或前端页面，同步更新对应文档和测试。

## 架构约束

- 保留 RuoYi-Vue-Plus 现有多模块结构，不再把文档目标写成不存在的 `bootstrap/shared/modules` 目录。
- 公共横切能力优先沉淀到 `ruoyi-common-*`。
- 业务能力优先落在 `ruoyi-modules/*`。
- 启动、聚合依赖和应用配置优先落在 `ruoyi-admin`。
- 独立运维扩展优先落在 `ruoyi-extend`。
- 新增前端功能按 `web/src/api` 与 `web/src/views` 的既有功能域组织。

## 不再作为当前事实维护的说法

以下说法不得继续作为当前仓库事实传播：

- 当前系统是 ProjectPilot 项目管理 MVP。
- 当前前端尚未建立，需要创建 `web/apps/projectpilot-web`。
- 当前默认使用 Flyway 管理数据库迁移。
- 当前 CI/CD 已经以 `services/callcenter-server` 为真实源码路径稳定运行。
- CallCenter 是当前代码结构来源或业务模板。

## 与 Harness Engineering 的关系

Harness Engineering 在这里的作用不是增加概念，而是让技术事实可导航、可验证、可自动检查：

- 用 [docs/architecture/code-map.md](code-map.md) 固定真实代码地图。
- 用 [docs/README.md](../README.md) 固定任务入口。
- 用 [docs/reviews/README.md](../reviews/README.md) 和验证模板固定评审与交付证据。
- 后续把元数据、链接、路径、workflow 和 SQL 同步规则转成自动校验。
