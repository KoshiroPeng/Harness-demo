---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 参考文档目录入口，汇总当前 API 摘要、响应码、错误消息与共享事实资料。
---

# 参考文档总览

## 目标

本目录沉淀 HarnessBase 的接口、响应码、错误消息和共享事实资料。当前系统的完整接口文档主要由 SpringDoc 从后端代码生成；本目录只维护仓库级摘要、响应模型和人工协作时必须核对的事实。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 摘要 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 响应码与错误消息 | [docs/reference/error-codes.md](error-codes.md) |
| SQL 脚本变更清单 | [docs/reference/sql-change-checklist.md](sql-change-checklist.md) |

## 事实来源

接口和错误模型必须优先核对这些真实入口：

- SpringDoc 配置：[server/ruoyi-admin/src/main/resources/application.yml](../../server/ruoyi-admin/src/main/resources/application.yml)、[SpringDocConfig.java](../../server/ruoyi-common/ruoyi-common-doc/src/main/java/org/dromara/common/doc/config/SpringDocConfig.java)
- 认证与验证码 Controller：[server/ruoyi-admin/src/main/java/org/dromara/web/controller](../../server/ruoyi-admin/src/main/java/org/dromara/web/controller)
- 后台业务 Controller：[server/ruoyi-modules](../../server/ruoyi-modules)
- 前端接口客户端：[web/src/api](../../web/src/api)
- 统一响应和分页响应：[R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java)、[TableDataInfo.java](../../server/ruoyi-common/ruoyi-common-mybatis/src/main/java/org/dromara/common/mybatis/core/page/TableDataInfo.java)
- 异常处理：[GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java)、[SaTokenExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-satoken/src/main/java/org/dromara/common/satoken/handler/SaTokenExceptionHandler.java)

## 使用建议

- 判断接口事实前，先看 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 修改接口前，核对 Controller、前端 [web/src/api](../../web/src/api) 和 SpringDoc 生成结果。
- 修改响应码、异常处理或 i18n 消息时，同步更新 [docs/reference/error-codes.md](error-codes.md)。
- 修改 SQL 相关行为时，同步检查 [server/script/sql](../../server/script/sql) 和 [docs/reference/sql-change-checklist.md](sql-change-checklist.md)。

如果当前任务是“先确认接口到底存不存在、前端调的是不是同一个路径”，再补充阅读：

- [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)
- 运行时 SpringDoc 页面或 `/v3/api-docs` 输出

## 运行时核对入口

基于 [server/ruoyi-admin/src/main/resources/application.yml](../../server/ruoyi-admin/src/main/resources/application.yml) 当前配置，可以直接确认：

- `server.servlet.context-path` 当前为 `/`。
- `springdoc.api-docs.enabled` 当前为 `true`。
- 因此运行时 OpenAPI JSON 可直接核对 `/v3/api-docs`。

以下地址属于基于当前源码配置得出的默认访问推断，若后续被网关、反向代理或额外配置改写，应以运行环境实际结果为准：

- SpringDoc UI 通常可访问 `/swagger-ui/index.html`。
- 若存在分组接口文档，分组展示以 SpringDoc 运行时页面为准。

## 已知差异

当前仓库级 reference 入口未记录新的前后端接口漂移项。

如果后续再次发现接口路径、响应结构或前端客户端与后端 Controller 不一致，应先补充验证证据，再把事实同步到：

- [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)
- [docs/plans/backlog.md](../plans/backlog.md)

## 推荐阅读顺序

1. [docs/architecture/code-map.md](../architecture/code-map.md)
2. [docs/architecture/data-flow.md](../architecture/data-flow.md)
3. [docs/reference/api-spec.yaml](api-spec.yaml)
4. [docs/reference/error-codes.md](error-codes.md)
5. [docs/reference/sql-change-checklist.md](sql-change-checklist.md)
6. [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)

## 维护规则

- API 摘要不能写入不存在的业务接口。
- 若接口由 SpringDoc 动态生成且不在摘要中列全，应在文档中说明范围。
- 响应码文档必须对齐 `R`、`HttpStatus`、`GlobalExceptionHandler` 和 i18n 消息。
- 发现前后端接口不一致时，先记录在“已知差异”，不要为了让摘要完整而虚构接口。
- SQL 变更必须明确初始化脚本、升级脚本、多数据库兼容和发布验证影响。
