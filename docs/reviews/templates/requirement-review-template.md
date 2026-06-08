---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 需求评审输出模板，用于统一记录需求评审结论、问题与后续动作。
---

# 需求评审输出模板

关联清单：

- [docs/reviews/requirement-review-checklist.md](../requirement-review-checklist.md)
- [docs/design/README.md](../../design/README.md)
- [docs/plans/README.md](../../plans/README.md)
- [docs/architecture/target-technology-baseline.md](../../architecture/target-technology-baseline.md)
- [docs/architecture/harness-engineering-adaptation.md](../../architecture/harness-engineering-adaptation.md)

```md
# 需求评审结论

## 基本信息

- 需求名称：
- 评审时间：
- 评审人：
- 关联迭代：
- 关联文档：

## 评审结论

- 结论：通过 / 有条件通过 / 不通过
- 结论说明：

## 核心检查结果

- 业务场景是否清晰：
- 业务流程是否清晰：
- 关键界面和交互是否清晰：
- 是否说明与现有功能的关系：
- 是否涉及外部系统或外部数据：
- 是否覆盖非功能性要求：
- 是否与当前技术基线和真实模块结构不冲突：
- 是否符合当前后台管理系统主线：
- 是否存在平台化范围偏航：

## 发现问题

| 序号 | 问题描述 | 影响范围 | 建议动作 | 责任人 |
| --- | --- | --- | --- | --- |
| 1 |  |  |  |  |

## 待补材料

- 

## 后续动作

- 
```

## 使用提醒

- 如果需求暂时只保留边界而不进入当前迭代，应在“结论说明”里明确写出“保留设计边界，不进入当前开发”。
- 如果需求关联现有功能、外部系统或非功能性要求，尽量把对应材料名称直接写在“关联文档”里，减少后续追溯成本。
