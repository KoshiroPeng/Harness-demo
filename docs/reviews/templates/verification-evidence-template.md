---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 验证证据输出模板，用于统一记录验证方式、结果与剩余风险。
---

# 验证证据输出模板

## 目标

本模板用于统一记录“这次改动如何被验证、验证到什么程度、还剩哪些风险未覆盖”。

适用场景：

- 功能开发完成后的自检说明
- 缺陷修复后的回归说明
- 评审完成后的补充验证记录
- 发布前后或回滚后的验证说明

## 推荐配套文档

- [docs/conventions/task-startup-checklist.md](../../conventions/task-startup-checklist.md)
- [docs/conventions/testing.md](../../conventions/testing.md)
- [docs/reviews/backend-code-review-checklist.md](../backend-code-review-checklist.md)
- [docs/reviews/frontend-code-review-checklist.md](../frontend-code-review-checklist.md)
- [docs/architecture/target-technology-baseline.md](../../architecture/target-technology-baseline.md)
- [docs/architecture/code-map.md](../../architecture/code-map.md)
- [deploy/release/release-checklist.md](../../../deploy/release/release-checklist.md)

```md
# 验证证据

## 基本信息

- 任务名称：
- 验证时间：
- 验证人：
- 关联需求 / 缺陷 / 评审：
- 变更范围：

## 验证目标

- 本次需要证明什么：
- 本次不覆盖什么：

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 |  |  | 通过 / 未通过 / 未执行 |  |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：
- 是否仍存在历史残留：
- 若存在残留，是否已记录到 backlog：

## 关键命令或操作记录

```text
在此记录执行过的关键命令、页面操作或检查路径
```

## 结果摘要

- 功能结果：
- 测试结果：
- 文档同步结果：
- 发布或运行验证结果：

## 未覆盖风险

- 

## 后续动作

- 
```

## 使用提醒

- 如果某项验证没有执行，不要省略，直接写明“未执行”和原因。
- 如果本次改动涉及 API、响应码、SQL、发布或观测方案，结果摘要中应明确写出是否已同步检查。
- 如果本次改动属于 workflow、发布路径、前端结构或模块边界调整，建议补写“基线对齐结果”。
- 如果仍有已知风险，不要把它藏在备注里，应单独写入“未覆盖风险”。
