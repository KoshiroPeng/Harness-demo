---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 业务扩展基线，定义新增业务功能时从需求、模块落位、前后端实现、SQL、权限、测试到验证证据的纵向闭环。
---

# 业务扩展基线

## 目标

本文档定义 HarnessBase 作为后续业务项目基线时的扩展方式。新增业务功能不能只按“写一个接口”或“加一个页面”推进，而要按可验证的纵向切片完成后端、前端、SQL、权限、测试、文档和发布影响的闭环。

HarnessBase 当前代码事实仍是 RuoYi-Vue-Plus 多租户后台管理系统。业务扩展应优先复用当前 [模块边界](boundaries.md)、[代码地图](code-map.md)、[功能域图谱](../design/feature-admin-domains.md) 和 [任务启动清单](../conventions/task-startup-checklist.md)，不要重新规划一套脱离现有代码的目标结构。

## 适用场景

以下任务开始前必须阅读本文档：

- 新增一个业务域或后台管理模块。
- 为现有业务域新增列表、详情、表单、导入、导出、审批或状态流转。
- 新增菜单、按钮权限、字典、配置项或初始化数据。
- 新增或调整前后端 API 契约。
- 新增业务表、字段、索引、关联关系或升级脚本。
- 把 `demo` 示例能力提升为正式业务能力。

## 纵向切片顺序

新增业务功能默认按下面顺序推进：

1. 定义业务边界：确认功能属于 system、monitor、tool/gen、workflow、demo，还是需要新增正式业务模块。
2. 定义数据边界：确认表、字段、索引、字典、菜单和权限是否需要进入 SQL 脚本。
3. 定义后端契约：确认 Controller 路径、权限标识、请求对象、响应对象、Service、Mapper 和异常语义。
4. 定义前端入口：确认 API 封装、页面、路由、菜单、按钮权限、表单校验和状态管理。
5. 定义测试范围：按风险补齐后端 JUnit 5、前端 Vitest 或联调验证。
6. 定义文档同步：同步 API 摘要、错误码、SQL 清单、设计说明、评审或验证证据。
7. 定义发布影响：确认 SQL 升级、环境变量、制品路径、回滚和观测入口是否受影响。

任何一步缺少证据时，应在任务记录或验证证据中明确标注未覆盖风险，不要默认视为已完成。

## 后端落位规则

新增后端能力先按当前模块边界判断落位：

| 变更类型 | 优先落位 | 说明 |
| --- | --- | --- |
| 系统管理、用户、角色、菜单、字典、参数、租户、OSS | [server/ruoyi-modules/ruoyi-system](../../server/ruoyi-modules/ruoyi-system) | 优先沿用 `system:*` 权限和现有 Controller / Service / Mapper 分层 |
| 代码生成 | [server/ruoyi-modules/ruoyi-generator](../../server/ruoyi-modules/ruoyi-generator) | 涉及模板、表元数据和生成配置时同步前端工具页 |
| 工作流 | [server/ruoyi-modules/ruoyi-workflow](../../server/ruoyi-modules/ruoyi-workflow) | 同步流程定义、任务、实例、表单跳转和 `ry_workflow.sql` |
| 任务调度客户端能力 | [server/ruoyi-modules/ruoyi-job](../../server/ruoyi-modules/ruoyi-job) | 独立调度服务仍以 [server/ruoyi-extend](../../server/ruoyi-extend) 为运维扩展 |
| 通用基础能力 | [server/ruoyi-common](../../server/ruoyi-common) | 只有跨模块复用且边界稳定时才进入 common |
| 独立运维扩展 | [server/ruoyi-extend](../../server/ruoyi-extend) | 仅适用于独立运行或运维支撑服务 |
| 新正式业务域 | [server/ruoyi-modules](../../server/ruoyi-modules) | 先确认现有模块无法承载，再新增模块并更新代码地图 |

后端实现必须遵守：

- `ruoyi-admin` 只承载启动、装配、配置和少量 Web 入口聚合，不堆叠大段业务规则。
- Controller 负责协议适配、权限注解、参数入口和响应包装，不承载复杂业务编排。
- 业务规则进入 Service 或领域内聚类；持久化细节进入 Mapper、XML 或 MyBatis-Plus 约定层。
- 外部系统调用通过 common、adapter、client 或明确封装类接入，不在业务方法里散落 SDK 初始化。
- 新代码统一使用 `jakarta.*`、构造器注入和 SLF4J。

## 前端落位规则

新增前端能力先按现有目录放置：

| 变更类型 | 优先落位 | 说明 |
| --- | --- | --- |
| API 封装和类型 | [web/src/api](../../web/src/api) | 路径、方法、参数和返回值必须能回到后端 Controller 或 SpringDoc 核对 |
| 页面和业务组件 | [web/src/views](../../web/src/views) | 按 system、monitor、tool、workflow、demo 或新增业务域组织 |
| 共享组件 | [web/src/components](../../web/src/components) | 只有跨页面复用且语义稳定时抽出 |
| 路由守卫和动态路由 | [web/src/router](../../web/src/router) | 与后端菜单、权限标识和用户权限加载保持一致 |
| 全局状态 | [web/src/store](../../web/src/store) | 只放跨页面共享状态，不把单页面表单状态上提为全局状态 |

前端实现必须遵守：

- 不新增后端不存在的 API 封装；如果先写前端 mock，必须在任务记录中标明替换条件。
- 页面按钮权限要与 SQL 菜单权限、后端 `@SaCheckPermission` 或等价权限校验一致。
- 新增列表页时同步考虑查询条件、分页、排序、导出、空状态和错误态。
- 新增表单页时同步考虑校验、重复提交、权限不足、租户隔离和后端错误消息。

## SQL、菜单和权限

当前数据库事实由 [server/script/sql](../../server/script/sql) 维护，不是 Flyway migration。涉及表结构、初始化数据、字典、菜单、按钮权限或工作流数据时，必须同步检查：

- MySQL 初始化脚本和 [server/script/sql/update](../../server/script/sql/update) 升级脚本。
- Oracle、PostgreSQL、SQL Server 兼容脚本是否受影响。
- `sys_menu` 菜单、按钮权限、前端按钮控制和后端权限注解是否一致。
- 字典、参数、租户套餐、客户端配置或工作流初始化数据是否需要发布说明。
- 删除字段、表、菜单或字典前，是否还有前端页面、后端 Mapper、XML、导出模板或测试继续引用。

SQL 变更记录和验证方式统一参考 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)。

## API、错误码和响应

新增或调整 API 时必须确认：

- 后端路径、HTTP 方法、权限标识和前端 API 封装一致。
- 列表响应、详情响应、导出响应、文件上传下载和异步任务响应符合当前响应模型。
- 业务失败使用当前异常处理和错误消息体系，不在 Controller 中手写零散响应。
- 涉及新增响应码、i18n 消息或异常语义时，同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 仓库级 API 摘要只记录已从真实 Controller 核对过的代表入口，同步时更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 或说明由 SpringDoc 运行时生成覆盖。

## 测试和验证

新增业务功能至少按风险选择以下验证：

| 范围 | 推荐验证 |
| --- | --- |
| Service 规则 | JUnit 5 单元测试，覆盖成功、失败、边界和权限相关分支 |
| Controller 契约 | Web 层测试或集成验证，覆盖参数校验、权限和响应模型 |
| Mapper / XML / SQL | 数据访问测试、SQL 语法检查或真实数据库初始化验证 |
| 前端 API 和页面 | Vitest、组件测试或本地页面联调验证 |
| 菜单和权限 | 登录后菜单可见性、按钮权限和后端权限注解一致性验证 |
| 发布影响 | 构建、脚本路径、升级 SQL、回滚说明和观测入口检查 |

高风险任务完成前，优先使用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 留存验证证据。

## 文档同步清单

新增业务功能结束前检查：

- [ ] 是否需要更新 [docs/architecture/code-map.md](code-map.md)。
- [ ] 是否需要更新 [docs/architecture/boundaries.md](boundaries.md)。
- [ ] 是否需要更新 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) 或新增功能域设计文档。
- [ ] 是否需要更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- [ ] 是否需要更新 [docs/reference/error-codes.md](../reference/error-codes.md)。
- [ ] 是否需要更新 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 或 SQL 变更记录。
- [ ] 是否需要更新 [deploy/release/README.md](../../deploy/release/README.md) 或发布检查材料。
- [ ] 是否需要补充评审记录、测试说明或验证证据。

## 禁止事项

- 禁止绕过当前 RuoYi-Vue-Plus 目录事实，新增不存在的 `bootstrap/shared/modules` 目标结构。
- 禁止只新增前端 API 封装但没有后端 Controller 或明确 mock 替换计划。
- 禁止只新增后端接口但不同步前端调用、权限、API 摘要或验证证据。
- 禁止只改数据库实体、Mapper 或 XML，不维护初始化脚本和升级脚本。
- 禁止把 `demo` 示例能力直接当成正式业务事实扩张；转正前必须重新定义边界、权限、SQL、测试和发布影响。
- 禁止为了“平台化”提前引入微服务、Kubernetes 或过重治理体系，除非有明确业务约束和验证计划。

## 一句话准则

在 HarnessBase 上扩展业务时，每个功能都应能从一个业务目标追到后端模块、前端页面、SQL 权限、API 契约、测试结果和验证证据。
