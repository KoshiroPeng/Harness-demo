---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 测试用例评审输出模板，用于统一记录测试覆盖、缺口与回归安排。
---

# 测试用例评审输出模板

关联清单：

- [docs/reviews/testcase-review-checklist.md](../testcase-review-checklist.md)
- [docs/conventions/testing.md](../../conventions/testing.md)
- [docs/architecture/target-technology-baseline.md](../../architecture/target-technology-baseline.md)
- [deploy/release/release-checklist.md](../../../deploy/release/release-checklist.md)
- [docs/architecture/harness-engineering-adaptation.md](../../architecture/harness-engineering-adaptation.md)

```md
# 测试用例评审结论

## 基本信息

- 用例范围：
- 评审时间：
- 评审人：
- 关联需求：
- 关联缺陷：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 需求覆盖是否完整：
- 缺陷回归覆盖是否完整：
- 测试步骤是否清晰：
- 前置条件、异常场景和数据量是否覆盖：
- 集成测试和核心回归是否覆盖：
- 是否覆盖本次 SQL、workflow、发布或结构调整带来的新增风险：
- 是否优先覆盖当前后台管理主链路：
- 是否被次要平台流程分散重点：

## 发现问题

| 序号 | 问题描述 | 影响范围 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## 建议补充用例

- 

## 后续动作

- 
```

## 使用提醒

- 若用例覆盖的是缺陷修复，建议在“关联缺陷”中写清缺陷编号或问题现象，并在“建议补充用例”中标记回归范围。
- 若测试范围涉及发布验证、环境依赖或外部系统，建议同步引用 [deploy/release/README.md](../../../deploy/release/README.md)。
