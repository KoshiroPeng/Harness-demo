---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后台设计评审清单，用于检查数据库、接口、模块边界与后端逻辑设计。
---

# 后台设计评审清单

## 评审重点

1. 数据库设计
2. 接口设计
3. 对调整的接口逻辑进行说明

## 适用范围

- 新增后端功能的详细设计评审
- 影响表结构、接口或外部调用的后端改造评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 是否按模板要求编写详细设计说明书？ |
| 必选 | 2 | 表结构设计是否有主键，是否有合理的索引？ |
| 必选 | 3 | 表名、字段名、索引名命名是否符合规范，是否使用保留关键字，表命名是否符合项目约定？ |
| 必选 | 4 | 是否存在冗余字段，是否避免冗余大字段和频繁修改字段，是否考虑数据一致性？ |
| 必选 | 5 | 字段类型及长度是否合理？ |
| 必选 | 6 | 新增表是否和已有表存在关系，是否设计了历史数据处理方式？ |
| 必选 | 7 | 新增字段是否设计了历史数据处理方式？ |
| 必选 | 8 | 是否每个功能都有明确的调用接口设计，接口参数是否齐全？ |
| 必选 | 9 | 接口名、参数名是否遵循命名规范，是否与既有接口冲突？ |
| 必选 | 10 | 接口请求方式是否合理，是否避免不必要的不安全设计？ |
| 必选 | 11 | 接口入参与出参是否有清晰描述，是否满足需求？ |
| 必选 | 12 | 接口返回结果数量是否有评估，是否需要分页，是否存在性能风险？ |
| 必选 | 13 | 若涉及 WebSocket、Redis 或消息结构，消息结构和存储结构是否合理？ |
| 必选 | 14 | 是否有使用公共方法类，是否需要抽取新的公共方法？ |
| 必选 | 15 | 接口逻辑是否设计了输入校验和结果错误检查？ |
| 必选 | 16 | 是否存在外部调用，是否设计了调用失败、结果异常和响应时长控制？ |
| 必选 | 17 | 是否存在频繁操作数据库的情况？ |
| 必选 | 18 | 若涉及缓存，是否考虑了缓存更新与一致性？ |
| 必选 | 19 | 若涉及定时执行，定时周期是否支持动态调整，是否支持手动启停？ |
| 必选 | 20 | 若涉及同步数据接口，中间数据是否有记录，处理逻辑是否明确？ |
| 必选 | 21 | 是否有调整现有接口或 SQL，调整内容是否有清晰说明？ |
| 必选 | 22 | 设计是否围绕当前业务闭环的最小实现，而不是过早引入平台化抽象？ |
| 可选 | 23 | 接口设计是否考虑到后期扩展性？ |

## 当前项目适配说明

- 表结构与 SQL 应以 [server/script/sql](../../server/script/sql) 的当前脚本体系为事实来源，并评估索引、排序规则、时间字段和升级兼容性。
- 数据库结构变更必须同步初始化 SQL 和 `update/` 升级脚本；当前不能假定 Flyway 已落地。
- 后端模块必须遵守 [docs/architecture/boundaries.md](../architecture/boundaries.md) 中的真实 RuoYi-Vue-Plus 模块边界。
- 外部调用必须通过已有 common 能力、adapter、client 或明确封装类接入。
- 如果设计以 Harness Engineering 名义引入新平台层、通用流程层或超前抽象，应先对照 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md) 做偏航检查。
- 设计评审中若已确认涉及发布、回滚、环境变量、上线验证或观测要求，应同步参考 [deploy/release/README.md](../../deploy/release/README.md) 与 [deploy/observability/README.md](../../deploy/observability/README.md)。
- 命名、错误处理、测试策略分别参考 [docs/conventions/naming.md](../conventions/naming.md)、[docs/conventions/error-handling.md](../conventions/error-handling.md)、[docs/conventions/testing.md](../conventions/testing.md)。
