---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第二阶段历史事实误用扫描接入说明，定义关键词扫描的范围、忽略规则、提示策略与验收方式。
---

# 第二阶段历史事实误用扫描接入说明

## 目标

本文档用于说明 HarnessBase 第二阶段自动化检查，也就是历史事实误用扫描，当前如何接入本地脚本和 CI、如何解释提醒输出、后续如何维护命中词与忽略语境。

本说明只描述：

- 扫描哪些误用
- 提示而不是阻断的原因
- 如何降低误报
- 如何验收扫描结果

## 适用范围

第二阶段只覆盖以下检查项：

1. A04：历史事实误用扫描

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 当前状态

截至 2026-06-09，第二阶段已经接入当前文档护栏脚本：

- A04 已由 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 覆盖。
- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 已在后端和前端构建前执行该脚本。
- 当前为提醒模式；命中项会输出文件、行号和命中词，但不会作为阻断退出码。
- 本地执行 `python .github/scripts/doc_guardrails.py` 应输出 A01/A02/A03/A04/A05 通过。
- 当前词表覆盖旧若依单体语境、旧包名、旧 SQL 路径、旧前端栈和已移除项目名。

## 为什么放在第二阶段

这类检查和第一阶段不同：

- 它不只是路径或字段存在性问题
- 它依赖上下文判断
- 同一个关键词可能出现在“误用”或“历史说明”两种语境里

因此它更适合在第一阶段硬校验稳定后，以“先提醒、后收敛”的方式接入。

## 接入位置

当前已接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

接入方式：

- 复用 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 初期不阻断 workflow
- 在脚本输出中明确标记为“提醒”

## 推荐扫描对象

结合当前仓库现状，优先扫描：

- 历史过渡产品名
- 旧行业业务叙事
- 不存在的旧源码路径
- 把 `Flyway` 写成当前已落地事实

事实来源：

- [AGENTS.md](../../AGENTS.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)

## 推荐忽略策略

为了降低误报，当前脚本允许以下场景：

- 写明“历史背景”的段落
- 写明“禁止误用”的规则段落
- 写明“后续若引入”的条件性说明
- 文档治理验证证据中对历史问题的复盘记录
- 写明“命中词”“扫描对象”“高风险命中词”的规则说明段落

不建议一开始就：

- 只要命中关键词就直接失败
- 不区分规则文档和业务说明文档

## 推荐输出方式

输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

最小输出要求：

- 明确检查编号 `A04`
- 明确结果级别为 `提醒`
- 明确命中文件与命中词
- 明确需要人工判断是否属于误用
- 明确规则来源文档

## 推荐结果沉淀方式

这类扫描初期更适合做“试运行记录”，建议：

- 使用 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) 记录命中情况
- 如果调整了忽略规则或命中词口径，可补 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 推荐验收标准

第二阶段当前已满足：

1. 能稳定提示明显的历史事实误用
2. 不会把“历史背景说明”大面积误判为问题
3. 能让开发者从输出中直接看到命中词和文件路径
4. 仍以提醒为主，不强制阻断主线

## 维护步骤

后续维护按以下顺序推进：

1. 本地执行 `python .github/scripts/doc_guardrails.py`
2. 如出现 A04 提醒，先判断是否为真实误用
3. 如是误报，优先补充明确的纠偏语境或调整忽略关键词
4. 收敛忽略规则
5. 再决定是否把少量高置信项升级为阻断

## 与当前文档的关系

- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- 实施顺序：见 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- 报错口径：见 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

## 一句话结论

第二阶段已经作为非阻断提醒接入当前文档护栏脚本，维护重点是持续校准命中词和上下文豁免，防止旧项目名、旧路径和旧技术栈重新污染当前事实主线。
