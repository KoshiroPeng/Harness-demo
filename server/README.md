---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 后端工程入口，汇总当前微服务模块、启动入口、常用命令、SQL 路径与后端协作导航。
---

# 后端工程入口

## 目标

本文档是 HarnessBase 后端工程的本地入口，围绕当前仓库里的真实微服务结构、启动入口、构建方式和联读文档组织。

## 当前结构

后端根目录：[server](.)

```text
server/
├── ruoyi-auth/
├── ruoyi-gateway/
├── ruoyi-visual/
├── ruoyi-modules/
├── ruoyi-api/
├── ruoyi-common/
├── sql/
├── docker/
├── bin/
└── pom.xml
```

## 模块导航

| 模块 | 说明 |
| --- | --- |
| [ruoyi-gateway](./ruoyi-gateway) | 网关服务入口 |
| [ruoyi-auth](./ruoyi-auth) | 认证服务 |
| [ruoyi-api](./ruoyi-api) | 服务间远程接口定义 |
| [ruoyi-common](./ruoyi-common) | 公共能力模块 |
| [ruoyi-modules](./ruoyi-modules) | 业务服务集合 |
| [ruoyi-modules/ruoyi-system](./ruoyi-modules/ruoyi-system) | 系统服务 |
| [ruoyi-modules/ruoyi-gen](./ruoyi-modules/ruoyi-gen) | 代码生成服务 |
| [ruoyi-modules/ruoyi-job](./ruoyi-modules/ruoyi-job) | 定时任务服务 |
| [ruoyi-modules/ruoyi-file](./ruoyi-modules/ruoyi-file) | 文件服务 |
| [ruoyi-visual/ruoyi-monitor](./ruoyi-visual/ruoyi-monitor) | 监控服务 |
| [sql](./sql) | 当前 SQL 脚本目录 |
| [docker](./docker) | 历史 Docker 资产与容器化参考材料 |
| [bin](./bin) | 启动辅助脚本 |

## 启动入口

| 服务 | 启动类 |
| --- | --- |
| 网关 | [RuoYiGatewayApplication.java](./ruoyi-gateway/src/main/java/com/ruoyi/gateway/RuoYiGatewayApplication.java) |
| 认证 | [RuoYiAuthApplication.java](./ruoyi-auth/src/main/java/com/ruoyi/auth/RuoYiAuthApplication.java) |
| 系统 | [RuoYiSystemApplication.java](./ruoyi-modules/ruoyi-system/src/main/java/com/ruoyi/system/RuoYiSystemApplication.java) |
| 生成 | [RuoYiGenApplication.java](./ruoyi-modules/ruoyi-gen/src/main/java/com/ruoyi/gen/RuoYiGenApplication.java) |
| 任务 | [RuoYiJobApplication.java](./ruoyi-modules/ruoyi-job/src/main/java/com/ruoyi/job/RuoYiJobApplication.java) |
| 文件 | [RuoYiFileApplication.java](./ruoyi-modules/ruoyi-file/src/main/java/com/ruoyi/file/RuoYiFileApplication.java) |
| 监控 | [RuoYiMonitorApplication.java](./ruoyi-visual/ruoyi-monitor/src/main/java/com/ruoyi/modules/monitor/RuoYiMonitorApplication.java) |

## 常用命令

在 [server](.) 目录执行：

```bash
mvn -B -DskipTests package
mvn -B test
```

聚焦模块编译示例：

```bash
mvn -B -pl ruoyi-auth -am -DskipTests compile
mvn -B -pl ruoyi-gateway -am -DskipTests compile
mvn -B -pl ruoyi-modules/ruoyi-system -am -DskipTests compile
```

## 开发时重点关注

- 服务边界与依赖规则：[docs/architecture/boundaries.md](../docs/architecture/boundaries.md)
- 真实代码地图：[docs/architecture/code-map.md](../docs/architecture/code-map.md)
- docker-compose 部署入口：[deploy/compose/README.md](../deploy/compose/README.md)
- 后端开发执行指南：[docs/conventions/task-startup-checklist.md#开发后端代码](../docs/conventions/task-startup-checklist.md#开发后端代码)
- 后端代码评审清单：[docs/reviews/backend-code-review-checklist.md](../docs/reviews/backend-code-review-checklist.md)
- 后端设计评审清单：[docs/reviews/backend-design-review-checklist.md](../docs/reviews/backend-design-review-checklist.md)

## SQL 与配置事实

- 当前 SQL 事实目录是 [server/sql](./sql)
- 当前仓库未见 Flyway migration 体系
- 服务配置与 Nacos 联动入口可从各服务 `bootstrap.yml` 开始核对
- 如果需要做整套微服务容器化部署，当前正式入口以 [deploy/compose](../deploy/compose) 为准，不再以 [server/docker](./docker) 作为发布主入口

## 维护规则

- 新增或删除服务、模块、启动入口、脚本目录时，必须同步更新本文档和 [docs/architecture/code-map.md](../docs/architecture/code-map.md)。
- 如果后端结构变化会影响开发、评审、发布或回滚主路径，必须同步更新 [docs/README.md](../docs/README.md)。
