---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 参考文档目录入口，汇总当前 API 摘要、响应码、错误消息与共享事实资料。
---

# 参考文档总览

## 目标

本目录沉淀 HernessDemo 的接口、响应码、错误消息和共享事实资料。当前系统的完整接口文档主要由 SpringDoc 从后端代码生成；本目录维护仓库级摘要和人工协作时必须核对的事实。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 摘要 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 响应码与错误消息 | [docs/reference/error-codes.md](error-codes.md) |

## 使用建议

- 判断接口事实前，先看 [docs/architecture/code-map.md](../architecture/code-map.md)。
- 修改接口前，核对 Controller、前端 [web/src/api](../../web/src/api) 和 SpringDoc 生成结果。
- 修改响应码、异常处理或 i18n 消息时，同步更新 [docs/reference/error-codes.md](error-codes.md)。
- 修改 SQL 相关行为时，同步检查 [server/script/sql](../../server/script/sql)。

## 推荐阅读顺序

1. [docs/architecture/code-map.md](../architecture/code-map.md)
2. [docs/architecture/data-flow.md](../architecture/data-flow.md)
3. [docs/reference/api-spec.yaml](api-spec.yaml)
4. [docs/reference/error-codes.md](error-codes.md)

## 维护规则

- API 摘要不能写入不存在的业务接口。
- 若接口由 SpringDoc 动态生成且不在摘要中列全，应在文档中说明范围。
- 响应码文档必须对齐 `R`、`HttpStatus`、`GlobalExceptionHandler` 和 i18n 消息。
