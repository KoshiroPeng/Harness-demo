---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化检查结果模板，用于统一记录自动化校验的范围、命中项、结论与后续动作。
---

# 自动化检查结果模板

## 目标

本模板用于统一记录 HarnessBase 自动化检查的执行结果，适用于本地脚本、CI 流水线、手工补录和验证证据沉淀。

## 适用场景

- 新增自动化检查脚本后的首次验证
- CI 中某类自动化检查失败后的结果整理
- 自动化检查从提醒升级为阻断前的试运行记录
- 周期性回顾文档治理、workflow 路径或同步提醒效果

## 推荐联读

- [docs/conventions/automation-check-catalog.md](../../conventions/automation-check-catalog.md)
- [docs/conventions/harness-automation-roadmap.md](../../conventions/harness-automation-roadmap.md)
- [docs/plans/harness-automation-implementation-brief.md](../../plans/harness-automation-implementation-brief.md)
- [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md)

```md
# 自动化检查结果

## 基本信息

- 检查名称：
- 检查编号：
- 执行时间：
- 执行环境：本地 / CI / 其他
- 执行人或执行来源：
- 关联脚本 / workflow：

## 检查范围

- 扫描目录：
- 扫描文件类型：
- 忽略规则：
- 关联规则来源：

## 执行结果

| 序号 | 命中项 | 级别 | 结果 | 说明 |
| --- | --- | --- | --- | --- |
| 1 |  | 阻断 / 提醒 | 通过 / 未通过 / 未执行 |  |

## 输出摘要

- 总扫描数：
- 通过数：
- 失败数：
- 提醒数：
- 是否阻断流水线：

## 典型命中样例

```text
在此记录具有代表性的命中输出、路径、字段名或报错片段
```

## 结论

- 本次检查是否可直接接入主线：
- 当前误报情况：
- 当前漏报风险：

## 后续动作

- 
```

## 使用提醒

- 如果检查尚未真正接入 CI，也可以先按模板记录试运行结果。
- 如果某项检查本次选择“提醒不阻断”，应在结论里写明原因。
- 如果误报较多，不要只写“待优化”，应明确是扫描范围、忽略规则还是提示文案需要调整。
- 若检查直接关联发布、SQL、API 或响应码同步，建议同步补 [docs/reviews/templates/verification-evidence-template.md](verification-evidence-template.md)。
