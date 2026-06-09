---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase A04 历史事实误用扫描本地试运行记录，说明提醒模式、命中情况、误报处理和阶段验收结论。
---

# A04 历史事实误用扫描试运行记录

## 基本信息

- 阶段：第二阶段历史事实误用扫描
- 检查编号：A04
- 试运行时间：2026-06-09
- 执行环境：本地
- 执行人：Codex
- 关联脚本 / workflow：[.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)、[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

## 试运行目标

- 验证 A04 能扫描活跃 Markdown 主路径中的旧项目名、旧目录、旧包名和旧前端技术栈。
- 验证 A04 当前为提醒模式，不因提醒项阻断主线。
- 验证规则文档中的“历史、误用、纠偏、禁止、不是、当前不存在、命中词”等合法说明语境不会被当成误用传播。

## 试运行结果

| 序号 | 验证项 | 结果 | 说明 |
| --- | --- | --- | --- |
| 1 | 当前仓库全量扫描 | 通过 | `python .github/scripts/doc_guardrails.py` 输出 A01/A02/A03/A04/A05 通过 |
| 2 | 临时误用样例扫描 | 通过 | 临时 Markdown 中写入 `Vue 3` 和 `Vite` 后，A04 输出提醒但退出码仍为 0 |
| 3 | 合法纠偏语境忽略 | 通过 | `AGENTS.md` 和检查目录中的禁用词表不会触发提醒 |

## 命中情况

- 当前正式文件命中总数：0
- 临时样例命中总数：2
- 明显真阳性：临时样例中的 `Vue 3`、`Vite`
- 可能误报：当前未发现
- 可能漏报：自然语言改写的旧事实叙事仍需人工评审辅助识别

## 代表性输出

```text
[A04][提醒] 历史事实误用扫描发现需要人工复核的命中项
1. 文件: docs/__a04_temp_check.md
   问题: 第 10 行疑似历史事实误用: Vue 3
2. 文件: docs/__a04_temp_check.md
   问题: 第 10 行疑似历史事实误用: Vite

[A01/A02/A03/A04/A05][通过] 未发现阻断问题
说明: A04 当前为提醒模式，命中项只提示人工复核，不阻断主线
```

## 阶段验收结论

- 是否通过阶段验收：通过
- 当前建议状态：可接入 CI，并继续以提醒模式运行
- 对应验收清单：[docs/plans/automation-phase-acceptance-checklist.md](../plans/automation-phase-acceptance-checklist.md)

## 后续动作

- 继续维护 A04 命中词表，优先覆盖旧项目名、旧目录、旧包名、旧前端技术栈和旧 SQL 路径。
- 若未来发现稳定高置信误用项，再评估是否将少量规则升级为阻断。
