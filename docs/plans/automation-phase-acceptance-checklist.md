---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化阶段验收清单，用于统一判断各阶段检查是否达到可试运行、可接入或可阻断状态。
---

# 自动化阶段验收清单

## 目标

本文档用于判断自动化检查各阶段是否已经达到：

- 可以开始试运行
- 可以接入 CI
- 可以升级为阻断

## 使用方式

- 每完成一个自动化阶段，至少对照本文档做一次验收。
- 验收结果建议同步记录到 [docs/reviews/templates/automation-pilot-verification-template.md](../reviews/templates/automation-pilot-verification-template.md)。
- 如果阶段验收不通过，不要直接宣布“自动化已完成”。

## 通用验收项

所有阶段开始前，先确认：

- [ ] 规则来源文档已明确
- [ ] 检查定义已写入 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- [ ] 输出文案符合 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- [ ] 结果记录方式已明确
- [ ] 至少保留一份试运行记录

## 第一阶段验收：文档结构类硬校验

对应文档：

- [docs/plans/phase1-doc-check-ci-brief.md](phase1-doc-check-ci-brief.md)

当前结论：

- 截至 2026-06-09，第一阶段已接入本地脚本和 CI 前置门禁。
- 验证命令：`python .github/scripts/doc_guardrails.py`

验收项：

- [x] `A01`、`A02`、`A03` 范围已明确
- [x] 根目录 [README.md](../../README.md) 豁免规则已明确
- [x] 模板目录和占位说明不会被误判
- [x] 链接与锚点缺失能稳定发现
- [x] 输出能直接定位到文件、字段、路径或锚点
- [x] 已完成至少一轮本地验证
- [x] 已接入 CI 前置门禁

## 第二阶段验收：历史事实误用扫描

对应文档：

- [docs/plans/phase2-history-scan-brief.md](phase2-history-scan-brief.md)

当前结论：

- 截至 2026-06-09，第二阶段已接入当前文档护栏脚本和 CI 前置门禁。
- 当前为提醒模式，不作为阻断退出码。
- 验证命令：`python .github/scripts/doc_guardrails.py`

验收项：

- [x] 命中词范围已明确
- [x] 能区分历史说明和误用传播
- [x] 输出能看见命中词和文件路径
- [x] 已完成至少一轮本地试跑
- [x] 已完成至少一轮非阻断提醒试运行
- [x] 当前误报已被记录和解释

## 第三阶段验收：workflow 路径护栏

对应文档：

- [docs/plans/phase3-workflow-path-check-brief.md](phase3-workflow-path-check-brief.md)

当前结论：

- 截至 2026-06-09，第三阶段已接入当前文档护栏脚本和 CI 前置门禁。
- 验证命令：`python .github/scripts/doc_guardrails.py`

验收项：

- [x] `working-directory` 校验有效
- [x] `cache-dependency-path` 校验有效
- [x] 构建产物、脚本、模板路径校验有效
- [x] 输出能定位到 workflow 文件和字段
- [x] 已按当前真实结构完成核对：
  - [x] 后端根目录是 [server](../../server)
  - [x] 前端根目录是 [web](../../web)
  - [x] SQL 目录是 [server/sql](../../server/sql)
- [x] 具备升级为阻断的条件

## 第四阶段验收：跨文档同步提醒

对应文档：

- [docs/plans/phase4-doc-sync-reminder-brief.md](phase4-doc-sync-reminder-brief.md)

验收项：

- [ ] API 相关变更会提醒核对参考文档
- [ ] 错误码与异常相关变更会提醒核对错误码文档
- [ ] SQL 相关变更会提醒核对脚本和发布材料
- [ ] 提醒中带有具体文档路径
- [ ] 至少完成一轮提醒模式试运行
- [ ] 当前提醒不会造成大面积噪音

## 阶段结论

每次阶段验收后，至少给出以下结论之一：

- 可继续试运行
- 可接入 CI
- 可升级为阻断
- 暂不适合接入，需要继续收敛
