# HernessDemo

HernessDemo 当前是一个基于 `RuoYi-Vue-Plus 5.6.1` 的多租户后台管理系统重构工作区。真实代码主线由 `server/` 后端、`web/` 前端、`deploy/` 发布与观测支撑材料、`docs/` 协作文档组成。

本仓库曾经存在 `ProjectPilot`、`CallCenter`、`herness-demo` 等历史命名和过渡说明。后续文档以当前代码事实为准：系统核心不是项目管理 MVP，而是 RuoYi-Vue-Plus 体系下的后台管理、租户、权限、系统配置、代码生成、工作流、监控与示例能力。

## 快速入口

- [AGENTS.md](AGENTS.md)：AI 协作规则、编码要求、Git 规则与任务入口。
- [docs/README.md](docs/README.md)：按任务场景组织的文档导航。
- [docs/architecture/code-map.md](docs/architecture/code-map.md)：当前代码地图与模块事实。
- [docs/architecture/overview.md](docs/architecture/overview.md)：系统架构总览。
- [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md)：当前技术基线。
- [docs/design/README.md](docs/design/README.md)：功能设计入口。
- [docs/plans/current-sprint.md](docs/plans/current-sprint.md)：当前文档与工程收敛计划。
- [docs/reviews/README.md](docs/reviews/README.md)：评审清单与模板入口。
- [deploy/release/README.md](deploy/release/README.md)：发布支撑材料。
- [deploy/observability/README.md](deploy/observability/README.md)：本地可观测性材料。

## 当前代码画像

后端位于 [server/](server)，Maven 根为 [server/pom.xml](server/pom.xml)。代码事实包括：

- `artifactId` 为 `ruoyi-vue-plus`，版本为 `5.6.1`。
- 运行基线为 JDK 17、Spring Boot 3.5.x、Spring Framework 6。
- 后端模块包括 `ruoyi-admin`、`ruoyi-common`、`ruoyi-modules`、`ruoyi-extend`。
- 业务模块主要落在 `ruoyi-modules/ruoyi-system`、`ruoyi-modules/ruoyi-generator`、`ruoyi-modules/ruoyi-job`、`ruoyi-modules/ruoyi-workflow`、`ruoyi-modules/ruoyi-demo`。
- SQL 初始化和版本升级脚本位于 [server/script/sql](server/script/sql)，当前不是 Flyway migration 体系。

前端位于 [web/](web)，包配置为 [web/package.json](web/package.json)。代码事实包括：

- `name` 为 `ruoyi-vue-plus`，版本为 `5.6.1-2.6.1`。
- 使用 Vue 3、TypeScript、Vite、Element Plus、Pinia、Vue Router、VXE Table。
- 页面目录已经覆盖 `system`、`monitor`、`tool/gen`、`workflow`、`demo` 等后台管理能力。

## 常用命令

后端：

```bash
cd server
mvn -B -DskipTests package
mvn -B test
```

前端：

```bash
cd web
npm install
npm run dev
npm run build:prod
```

当前前端没有锁文件固定包管理器；如后续统一为 `npm`、`pnpm` 或其他工具，应同步提交锁文件并更新本文档。

本地观测：

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

## 当前重点

- 让文档、代码事实、发布材料和 Harness Engineering 护栏对齐。
- 继续清理历史 `ProjectPilot`、`CallCenter`、空目录 `services/callcenter-server` 和错误 workflow 路径带来的误导。
- 保留 RuoYi-Vue-Plus 既有模块边界，新增能力优先按现有 `ruoyi-*` 模块体系扩展。
- 把高频规则沉淀为可执行检查，而不是继续堆叠新概念文档。
