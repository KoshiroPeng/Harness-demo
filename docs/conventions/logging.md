---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 日志规范，统一日志框架、字段选择与敏感信息处理要求。
---

# 日志规范

## 基本原则

- 统一使用 SLF4J `Logger`。
- 禁止 `System.out.println`。
- 禁止 `e.printStackTrace()`。
- 日志用于定位问题和审计关键业务动作，不用于替代错误处理。

## 日志级别

| 级别 | 使用场景 |
| --- | --- |
| `trace` | 极细粒度诊断，默认不开启 |
| `debug` | 开发和排查问题所需的内部状态 |
| `info` | 关键业务动作、启动完成、任务完成 |
| `warn` | 可恢复异常、降级、重试、疑似风险 |
| `error` | 不可恢复异常或需要人工介入的问题 |

## 推荐写法

使用参数化日志：

```java
log.info("创建用户成功 userId={} tenantId={}", userId, tenantId);
```

不要使用字符串拼接：

```java
log.info("创建用户成功 userId=" + userId);
```

## 敏感信息

日志中禁止输出：

- 密码
- 令牌
- 完整密钥
- 身份证号
- 银行卡号
- 手机号全文
- 邮箱全文

必要时只输出脱敏后的片段或内部 ID。

## 异常日志

记录异常时必须包含上下文：

```java
log.error("创建用户失败 tenantId={} userName={}", tenantId, userName, ex);
```

不要只记录异常消息：

```java
log.error(ex.getMessage());
```

## 追踪字段

推荐在日志中包含：

- `traceId`
- `userId`
- `tenantId`
- `userId`
- `roleId`
- `menuId`

这些字段用于跨服务、跨请求或跨模块定位问题。
