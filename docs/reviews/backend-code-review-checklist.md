---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后端代码评审清单，用于检查编码规范、异常处理、性能、SQL 脚本与模块边界风险。
---

# 后台代码评审清单

## 评审重点

1. 后台编码规范
2. 异常检查
3. 性能与稳定性风险

## 适用范围

- Java 后端代码评审
- Service、Mapper、Controller、配置类、基础设施适配器评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 变量、常量、方法名命名是否符合规范？ |
| 必选 | 2 | 类和方法是否有适当注释，关键逻辑代码块是否有必要说明？ |
| 必选 | 3 | 是否对入参、数据库查询结果和公共方法返回对象做了合理校验？ |
| 必选 | 4 | 是否对可能出现异常的逻辑进行了合理处理？ |
| 必选 | 5 | 是否存在未定义含义的裸数字？ |
| 必选 | 6 | 是否涉及多线程，是否存在线程安全问题？ |
| 必选 | 7 | 循环是否一定能结束，是否存在高风险多层嵌套循环？ |
| 必选 | 8 | SQL 是否关联超过 3 张表，是否评估过数据量和性能风险？ |
| 必选 | 9 | 是否存在远程调用，是否考虑了响应时长和失败处理？ |
| 必选 | 10 | 是否存在单个方法过于繁琐，是否可以通过公共代码收敛？ |
| 必选 | 11 | 若存在定时任务，是否支持手动控制启停，是否有重复执行风险？ |
| 必选 | 12 | 若需要处理历史数据，是否已准备脚本或迁移方案？ |
| 必选 | 13 | 是否有合理的日志输出？ |
| 必选 | 14 | 是否存在频繁操作数据库？ |
| 必选 | 15 | 若使用第三方工具类，是否评估过并发与稳定性问题？ |
| 必选 | 16 | 若存在异步操作，是否考虑数据一致性问题？ |
| 必选 | 17 | 是否引入了与当前阶段不匹配的平台化抽象、过度封装或额外框架？ |

## 当前项目适配说明

- 代码评审必须同时遵守 [AGENTS.md](../../AGENTS.md) 中的硬性规则。
- 如果代码以 Harness Engineering 名义引入新抽象，应先对照 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md) 判断是否真的服务当前主线。
- 注释、命名、错误处理、日志、文件规模、方法规模分别参考 [docs/conventions/naming.md](../conventions/naming.md)、[docs/conventions/error-handling.md](../conventions/error-handling.md)、[docs/conventions/logging.md](../conventions/logging.md)、[docs/conventions/file-size.md](../conventions/file-size.md)、[docs/conventions/method-size.md](../conventions/method-size.md)。
- 外部调用必须检查是否通过已有 common 能力、adapter、client 或明确封装类接入。
- 数据库变更必须检查是否已同步 [server/script/sql](../../server/script/sql) 初始化脚本和 `update/` 升级脚本。
