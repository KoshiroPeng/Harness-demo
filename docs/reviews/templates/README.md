---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 评审输出模板目录入口，汇总各阶段评审与验证证据模板。
---

# 评审输出模板总览

## 目标

本目录提供 HernessDemo 在需求评审、设计评审、代码评审和测试用例评审中的统一输出模板，帮助 AI 与人工评审都按同一结构记录结论、问题和后续动作。

## 使用原则

- 清单负责“检查什么”。
- 模板负责“如何输出结果”。
- 模板不重复定义规则，规则仍以 [docs/reviews/README.md](../README.md) 及相关规范文档为准。

## 模板索引

| 场景 | 模板 |
| --- | --- |
| 需求评审输出 | [docs/reviews/templates/requirement-review-template.md](requirement-review-template.md) |
| 后台设计评审输出 | [docs/reviews/templates/backend-design-review-template.md](backend-design-review-template.md) |
| 前端设计评审输出 | [docs/reviews/templates/frontend-design-review-template.md](frontend-design-review-template.md) |
| 后台代码评审输出 | [docs/reviews/templates/backend-code-review-template.md](backend-code-review-template.md) |
| 前端代码评审输出 | [docs/reviews/templates/frontend-code-review-template.md](frontend-code-review-template.md) |
| 测试用例评审输出 | [docs/reviews/templates/testcase-review-template.md](testcase-review-template.md) |
| 验证证据输出 | [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md) |

## 使用建议

- AI 在执行评审或自检时，应优先套用对应模板，再引用相关清单逐项填写。
- 若评审结果需要沉淀到 issue、PR 评论、评审纪要或测试记录中，优先复用模板结构，不要临时自由发挥。
- 当前已补齐前端设计评审和前端代码评审模板，可直接用于现有 `web/` 主线。
- 功能开发、自检、测试验证、发布验证完成后，建议额外使用 [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md) 统一沉淀验证结果。
- 若评审或验证涉及 SQL、workflow、发布路径或前端结构调整，建议在模板中显式写出“是否匹配当前代码事实”和“仍存在哪些历史残留”。

## 推荐阅读顺序

1. [docs/reviews/README.md](../README.md)
2. 对应阶段的评审清单
3. 对应阶段的评审模板
4. 对应的设计、规范、API 或发布支撑文档

## 维护规则

- 新增评审场景时，应同步补齐对应模板。
- 若模板中的字段长期无人使用，应收敛而不是继续扩张。
