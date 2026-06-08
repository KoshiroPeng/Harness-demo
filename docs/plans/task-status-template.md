---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 任务状态模板，用于统一记录目标、进展、验证与阻塞。
---

# 任务状态模板

## 目标

本模板用于统一沉淀任务执行状态，减少“任务做到哪了、验证到哪了、还差什么”的表达分歧。

适用场景：

- 功能开发任务
- 缺陷修复任务
- 发布准备或发布验证任务

## 推荐配套文档

- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)
- [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)
- [docs/plans/current-sprint.md](current-sprint.md)
- [docs/plans/backlog.md](backlog.md)

```md
# 任务状态

## 基本信息

- 任务名称：
- 任务类型：功能开发 / 缺陷修复 / 发布支撑 / 文档治理 / 其他
- 当前状态：未开始 / 进行中 / 已完成 / 已阻塞
- 负责人：
- 更新时间：
- 关联需求 / 缺陷 / 发布单：

## 目标与范围

- 本次目标：
- 本次非目标：
- 是否属于当前后台管理系统主线：

## 当前进展

- 已完成：
- 进行中：
- 尚未开始：

## 关键文档

- 已阅读文档：
- 已更新文档：
- 仍需更新文档：

## 验证情况

- 已完成验证：
- 尚未完成验证：
- 验证证据：

## 风险与阻塞

- 当前风险：
- 当前阻塞：
- 是否需要用户或评审者介入：

## 下一步动作

- 
```

## 使用提醒

- 如果状态是“已阻塞”，必须明确写出阻塞原因，而不是只写“待处理”。
- 如果任务已经完成但验证未完成，不应直接标记为“已完成”，应至少说明剩余验证缺口。
- 如果任务不属于当前后台管理系统主线，应在“目标与范围”里明确说明为什么仍需要执行。
