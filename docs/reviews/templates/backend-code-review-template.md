---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后端代码评审输出模板，用于统一记录后端代码评审结论与问题。
---

# 后台代码评审输出模板

关联清单：

- [docs/reviews/backend-code-review-checklist.md](../backend-code-review-checklist.md)
- [docs/conventions/README.md](../../conventions/README.md)
- [docs/conventions/testing.md](../../conventions/testing.md)
- [docs/architecture/target-technology-baseline.md](../../architecture/target-technology-baseline.md)
- [docs/architecture/code-map.md](../../architecture/code-map.md)
- [docs/architecture/harness-engineering-adaptation.md](../../architecture/harness-engineering-adaptation.md)

```md
# 后台代码评审结论

## 基本信息

- 变更名称：
- 评审时间：
- 评审人：
- 关联需求或缺陷：
- 关联代码范围：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 命名、注释、日志是否符合规范：
- 参数校验和异常处理是否完整：
- SQL、数据库访问和远程调用是否存在性能风险：
- 是否存在线程安全、异步一致性或定时任务风险：
- 是否补齐测试与回归验证：
- 是否符合 JDK 17 / Spring Boot 3 / `jakarta.*` 当前基线：
- 是否同步更新 API、响应码、SQL 或发布文档：
- 是否存在与当前阶段不匹配的平台化抽象：

## 发现问题

| 序号 | 问题描述 | 严重级别 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## 建议补充验证

- 

## 后续动作

- 
```

## 使用提醒

- 如果本次改动涉及 API、响应码、SQL、发布或观测方案，评审结论中应明确写出需要同步更新的文档。
- 如果本次改动触及 workflow 或发布路径，评审结论中应明确写出是否仍存在 `services/callcenter-server` 等历史残留。
- 如果发现“为了通用性而提前平台化”的倾向，应在“发现问题”中单列记录，不要只写在结论说明里。
