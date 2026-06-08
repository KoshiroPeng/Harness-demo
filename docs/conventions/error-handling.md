---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 错误处理规范，约束 R、HttpStatus、GlobalExceptionHandler、i18n 消息与对外响应方式。
---

# 错误处理规范

## 当前响应模型

HTTP API 当前使用统一响应对象 `R<T>`：

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {}
}
```

事实入口：

- [R.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/domain/R.java)
- [HttpStatus.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/constant/HttpStatus.java)
- [GlobalExceptionHandler.java](../../server/ruoyi-common/ruoyi-common-web/src/main/java/org/dromara/common/web/handler/GlobalExceptionHandler.java)
- [MessageUtils.java](../../server/ruoyi-common/ruoyi-common-core/src/main/java/org/dromara/common/core/utils/MessageUtils.java)

## 基本原则

- 业务错误使用明确异常或 `R.fail` 表达。
- 系统异常由统一异常处理器转换为标准响应。
- 禁止吞掉异常后只打印日志。
- 禁止新增 `e.printStackTrace()`。
- 对外响应不暴露堆栈、SQL、密钥或内部实现细节。
- 修改错误提示时，同步检查 i18n 文件和 [docs/reference/error-codes.md](../reference/error-codes.md)。

## 状态码约定

| code | 含义 |
| --- | --- |
| `200` | 操作成功 |
| `400` | 参数错误 |
| `401` | 未授权 |
| `403` | 权限不足 |
| `404` | 资源不存在 |
| `405` | HTTP 方法不支持 |
| `409` | 资源冲突 |
| `500` | 系统错误或默认失败 |
| `601` | 系统警告 |

## Service 层规则

- Service 层优先抛出业务异常或返回清晰业务结果，不直接处理 HTTP 协议。
- 事务内出现异常时，应保证数据一致性。
- 不要用返回 `null` 隐式表达业务失败。
- 对批量操作要明确部分失败和全部失败语义。

## Controller 层规则

- Controller 负责参数接收、校验入口和调用 Service。
- Controller 不写复杂业务分支。
- Controller 不直接捕获所有异常后返回普通成功响应。
- 异常到响应的通用映射交给 `GlobalExceptionHandler`。

## i18n 消息

认证、用户、租户等提示消息位于：

- [messages.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages.properties)
- [messages_zh_CN.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages_zh_CN.properties)
- [messages_en_US.properties](../../server/ruoyi-admin/src/main/resources/i18n/messages_en_US.properties)

新增消息键时，至少同步默认与中文文件；如果已有英文语种，也应同步英文文件。
