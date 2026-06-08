---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 响应码与错误消息文档，统一说明 R、HttpStatus、GlobalExceptionHandler 和 i18n 消息语义。
---

# 响应码与错误消息

## 当前模型

当前系统使用 `R<T>` 作为统一响应结构：

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
- [server/ruoyi-admin/src/main/resources/i18n](../../server/ruoyi-admin/src/main/resources/i18n)

## 通用 code

| code | 语义 | 说明 |
| --- | --- | --- |
| `200` | 成功 | `R.ok` 默认值 |
| `400` | 请求错误 | 参数格式、JSON 解析、请求体读取等错误 |
| `401` | 未授权 | 认证失败或登录态不可用 |
| `403` | 权限不足 | Sa-Token 权限或角色校验失败 |
| `404` | 不存在 | 请求地址或资源不存在 |
| `405` | 方法不支持 | HTTP 方法不支持 |
| `409` | 冲突 | 数据库唯一约束、重复记录等 |
| `500` | 失败或系统错误 | `R.fail` 默认值和系统异常 |
| `601` | 警告 | `R.warn` |

## 认证与租户消息键

| 消息键 | 默认含义 |
| --- | --- |
| `user.jcaptcha.error` | 验证码错误 |
| `user.jcaptcha.expire` | 验证码已失效 |
| `user.password.not.match` | 用户不存在或密码错误 |
| `user.password.retry.limit.count` | 密码错误次数提示 |
| `user.password.retry.limit.exceed` | 密码错误超限并锁定 |
| `user.login.success` | 登录成功 |
| `user.logout.success` | 退出成功 |
| `user.register.success` | 注册成功 |
| `auth.grant.type.error` | 认证授权类型错误 |
| `auth.grant.type.blocked` | 认证授权类型已禁用 |
| `tenant.not.exists` | 租户不存在 |
| `tenant.blocked` | 租户已禁用 |
| `tenant.expired` | 租户已过期 |

## 维护要求

- 新增或修改错误消息时，同步默认、中文和英文 i18n 文件。
- 新增异常映射时，同步检查 [docs/conventions/error-handling.md](../conventions/error-handling.md)。
- 不要把旧 ProjectPilot 的 `PROJECT_NOT_FOUND`、`TASK_STATUS_INVALID`、`BILLING_*` 等错误码当成当前事实。
- 对外响应不得暴露堆栈、SQL、密钥或内部配置。
