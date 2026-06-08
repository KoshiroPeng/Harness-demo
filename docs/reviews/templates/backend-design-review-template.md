---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后端设计评审输出模板，用于统一记录数据库、接口和逻辑设计评审结果。
---

# 后台设计评审输出模板

关联清单：

- [docs/reviews/backend-design-review-checklist.md](../backend-design-review-checklist.md)
- [docs/architecture/README.md](../../architecture/README.md)
- [docs/architecture/target-technology-baseline.md](../../architecture/target-technology-baseline.md)
- [docs/reference/README.md](../../reference/README.md)
- [docs/architecture/harness-engineering-adaptation.md](../../architecture/harness-engineering-adaptation.md)

```md
# 后台设计评审结论

## 基本信息

- 功能名称：
- 评审时间：
- 评审人：
- 关联需求：
- 设计文档：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 数据库设计是否合理：
- 接口设计是否完整：
- 历史数据处理是否明确：
- 是否符合 JDK 17 / Spring Boot 3 / 当前 SQL 脚本体系：
- 外部调用与异常处理是否明确：
- 缓存、定时任务、同步任务设计是否明确：
- 是否涉及交付、配置、发布或回滚影响：
- 是否符合当前 Harness Engineering 纠偏原则：
- 是否存在过早平台化抽象：

## 发现问题

| 序号 | 问题描述 | 风险等级 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## 需同步更新的文档

- 

## 后续动作

- 
```

## 使用提醒

- 若设计涉及数据库、接口、外部系统、缓存、定时任务或回滚策略，建议在“需同步更新的文档”中逐项写清文档名。
- 若评审通过的前提是后续补材料，也应把缺口写入“后续动作”，避免只停留在口头约定。
