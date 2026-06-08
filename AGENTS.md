---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 仓库级 AI 协作规则、当前代码事实、架构护栏与文档治理入口。
---

# AGENTS.md

本文件是 HernessDemo 仓库唯一的 AI 协作规则入口。所有 agent 在读取、修改或提交本仓库前，必须先阅读并遵守本文档。

## 回复与编码

- 默认使用简体中文回复。
- GitHub PR 评论、review comment、issue comment、代码审查结论、提交信息和新增代码注释必须使用简体中文。
- 代码标识符、API 名称、命令、错误信息和原文引用可以保留英文。
- 涉及代码、中文注释或中文文案的文件必须保持 UTF-8 编码，禁止改成 ANSI、GBK 或其他容易导致乱码的编码。

## 当前项目事实

HernessDemo 当前是基于 `RuoYi-Vue-Plus 5.6.1` 的多租户后台管理系统重构工作区，而不是项目管理 MVP 或 CallCenter 业务系统。

真实代码主线：

- 后端 Maven 根：[server/pom.xml](server/pom.xml)。
- 后端启动模块：[server/ruoyi-admin](server/ruoyi-admin)。
- 后端公共能力：[server/ruoyi-common](server/ruoyi-common)。
- 后端业务与扩展模块：[server/ruoyi-modules](server/ruoyi-modules)、[server/ruoyi-extend](server/ruoyi-extend)。
- 前端应用：[web](web)。
- 数据库脚本：[server/script/sql](server/script/sql)。
- 发布与观测支撑：[deploy](deploy)。

历史命名处理：

- `ProjectPilot`、`CallCenter`、`services/callcenter-server` 属于历史过渡痕迹，不能作为当前系统事实继续扩张。
- `herness-demo`、`HernessDemo`、`ruoyi-vue-plus`、`RuoYi-Vue-Plus` 分别可能出现在仓库名、部署名、制品名和脚手架标识中；新增文档应说明具体语境，不要混用成业务名称。

## 当前技术基线

- 后端运行时：JDK 17。
- 后端框架：Spring Boot 3.5.x / Spring Framework 6。
- 构建工具：Maven。
- 持久化：MyBatis-Plus Boot 3 体系、dynamic-datasource、SQL 脚本。
- 数据库：当前脚本覆盖 MySQL，并保留 Oracle、PostgreSQL、SQL Server 兼容脚本。
- 缓存与锁：Redis、Redisson、Lock4j。
- 认证授权：Sa-Token、JWT、JustAuth。
- 接口文档：SpringDoc。
- 前端：Vue 3、TypeScript、Vite、Element Plus、Pinia、Vue Router。
- 测试：后端 JUnit 5，前端 Vitest。

当前没有落地 Flyway migration；涉及数据库结构变更时，应优先沿用 [server/script/sql](server/script/sql) 的初始化脚本和 `update/` 升级脚本体系，除非本次任务明确引入并验证 Flyway。

## 快速导航

| 你想做什么 | 去哪里看 |
| --- | --- |
| 了解统一文档导航 | [docs/README.md](docs/README.md) |
| 了解真实代码地图 | [docs/architecture/code-map.md](docs/architecture/code-map.md) |
| 了解系统架构总览 | [docs/architecture/overview.md](docs/architecture/overview.md) |
| 了解目标技术基线 | [docs/architecture/target-technology-baseline.md](docs/architecture/target-technology-baseline.md) |
| 了解模块边界和依赖规则 | [docs/architecture/boundaries.md](docs/architecture/boundaries.md) |
| 了解 Harness Engineering 在本仓库中的用法 | [docs/architecture/harness-engineering-adaptation.md](docs/architecture/harness-engineering-adaptation.md) |
| 了解编码规范 | [docs/conventions/README.md](docs/conventions/README.md) |
| 了解当前迭代任务 | [docs/plans/current-sprint.md](docs/plans/current-sprint.md) |
| 了解 API 事实入口 | [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) |
| 了解响应码与错误消息 | [docs/reference/error-codes.md](docs/reference/error-codes.md) |
| 了解测试规范 | [docs/conventions/testing.md](docs/conventions/testing.md) |
| 了解评审清单入口 | [docs/reviews/README.md](docs/reviews/README.md) |
| 了解发布支撑材料 | [deploy/release/README.md](deploy/release/README.md) |
| 了解可观测性材料 | [deploy/observability/README.md](deploy/observability/README.md) |

## 代码结构规则

- 顶层目录保持清晰：`docs/` 放文档，`server/` 放后端，`web/` 放前端，`deploy/` 放发布与观测材料。
- 根目录只保留项目入口文件、仓库说明和必要配置。
- 不要新增第二个 agent 规则文件；本仓库只使用 `AGENTS.md`。
- 新增后端能力优先按现有 RuoYi-Vue-Plus 模块体系放置：启动装配进 `ruoyi-admin`，公共能力进 `ruoyi-common-*`，业务能力进 `ruoyi-modules/*`，独立运维扩展进 `ruoyi-extend/*`。
- 新增前端能力优先按现有 `web/src/api`、`web/src/views`、`web/src/router`、`web/src/store` 结构扩展。

## 硬性规则

1. 新增代码必须先确认现有模块边界，不要绕过 `ruoyi-common`、`ruoyi-modules`、`web/src/api` 等既有抽象。
2. 模块之间禁止为了方便直接跨层调用 Controller；后端内部协作优先通过 Service、Mapper、事件或公共能力模块完成。
3. 外部系统调用必须通过已有 common 能力、adapter、client 或明确封装类接入，禁止把第三方 SDK 零散扩散到业务方法中。
4. Spring Boot 3.x 主线下禁止新增 `javax.*` 依赖或旧命名空间，新代码统一使用 `jakarta.*`。
5. 横切关注点，例如 auth、log、tenant、cache、audit、rate limit、SSE、WebSocket，只能通过 Spring 注入或已有公共模块接入，禁止手动 `new` 扩散。
6. 禁止新增字段级 `@Autowired`，必须使用构造器注入，推荐 Lombok `@RequiredArgsConstructor`。
7. 禁止新增 `System.out.println` 和 `e.printStackTrace()`，统一使用 SLF4J `Logger`；历史启动 banner 输出属于待收敛遗留，不作为新增代码参考。
8. 新增业务代码必须有对应测试；缺陷修复必须补回归测试。
9. 数据库结构变更必须同步维护 [server/script/sql](server/script/sql) 下的初始化或升级脚本，并同步更新相关文档。
10. 涉及 API 变更时，同步更新 [docs/reference/api-spec.yaml](docs/reference/api-spec.yaml) 或说明为什么由 SpringDoc 动态生成覆盖。
11. 涉及响应码、异常处理或 i18n 消息变更时，同步更新 [docs/reference/error-codes.md](docs/reference/error-codes.md)。
12. 导航型文档、目录索引页和关键流程说明必须使用可点击 Markdown 链接，不要只保留纯文本路径。
13. 任何会影响“开发、测试、评审、发布”主路径的文档变更，都必须同步更新 [docs/README.md](docs/README.md) 或对应目录 `README.md`。
14. 新增内部 Markdown 文档时，必须在文件头部增加统一元数据标头：`last_updated`、`status`、`owner`、`description`；根目录 [README.md](README.md) 可作为对外入口文档豁免此要求。
15. 修改带有元数据标头的 Markdown 文档时，必须同步更新该文档标头中的 `last_updated` 日期。

## Harness Engineering 闭环要求

Harness Engineering 在本仓库中的含义是：用清晰入口、真实代码地图、可执行验证和自动化护栏，降低重构与协作的不确定性。

执行任务时默认遵守：

1. 开始前先完成统一入口阅读：`AGENTS.md` -> [docs/README.md](docs/README.md) -> [docs/architecture/code-map.md](docs/architecture/code-map.md) -> 对应任务场景文档。
2. 如果任务涉及架构、模块边界、发布、数据库脚本或 workflow，必须先核对真实文件，不允许只凭旧文档判断。
3. 如果任务跨多个文档、模块或阶段，优先使用 [docs/plans/task-status-template.md](docs/plans/task-status-template.md) 记录目标、进展、风险和待补文档。
4. 完成前如果任务涉及功能、缺陷、评审、测试、发布或重要文档治理，优先使用 [docs/reviews/templates/verification-evidence-template.md](docs/reviews/templates/verification-evidence-template.md) 记录验证方式、结果和未覆盖风险。
5. 新增规范、清单、模板或导航页后，必须让它能够从 [docs/README.md](docs/README.md) 或目录索引页直接进入。

## Git 与提交

需要提交代码时，必须执行完整 GitHub 流程：

1. 先执行 `git status`，确认当前分支和工作区状态。
2. 再执行 `git add` 暂存本次相关改动。
3. 然后执行 `git commit`，提交信息必须使用简体中文，并遵守提交类型规范。
4. 最后推送当前分支到 `origin`。
5. 如果当前分支没有 upstream，使用 `git push -u origin 当前分支名`。

禁止使用 `git push --force`、`git reset --hard`、`git clean` 等可能破坏历史或删除改动的命令，除非用户明确要求。远程仓库未配置、无权限、存在冲突或当前分支不明确时，必须暂停并说明具体问题，不要猜测处理。

## 提交类型

- `feat`：新功能
- `fix`：修复
- `refactor`：重构
- `docs`：文档
- `test`：测试
