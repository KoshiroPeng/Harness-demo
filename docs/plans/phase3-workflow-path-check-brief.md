---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 第三阶段 workflow 路径护栏说明，记录工作流路径存在性检查的接入状态、范围、输出与验收方式。
---

# 第三阶段 workflow 路径护栏接入说明

## 目标

本文档用于说明 HarnessBase 第三阶段自动化检查，也就是 workflow 路径存在性检查，当前如何接入、如何本地验证、后续如何维护。

## 当前状态

截至 2026-06-09，第三阶段已经接入当前文档护栏脚本：

- A05 已由 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 覆盖。
- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 已在后端和前端构建前执行该脚本。
- 本地执行 `python .github/scripts/doc_guardrails.py` 应输出 A01/A02/A03/A04/A05 通过。
- 第一版只校验能静态判断的仓库内路径；动态表达式、远端路径和构建产物目录不做阻断。

## 适用范围

第三阶段只覆盖以下检查项：

1. A05：workflow 路径存在性检查

检查定义以 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md) 为准。

## 为什么单独成阶段

workflow 路径问题通常具有高风险：

- 会让 CI 直接失效
- 会让发布、回滚、初始化流程指向错误目录
- 很容易因为目录调整或历史路径回流而再次出现

但它又和第一阶段的 Markdown 检查不同，因此适合单独成阶段处理。

## 接入位置

当前已接入：

- [agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

原因：

- 它本身就是最需要被路径护栏保护的 workflow
- 它承担主线门禁职责

## 推荐扫描范围

优先扫描：

- `.github/workflows/*.yml`

优先检查字段：

- `working-directory`
- `cache-dependency-path`
- 上传制品路径
- 发布脚本路径
- 模板路径

事实来源：

- [.github/README.md](../../.github/README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [deploy/release/README.md](../../deploy/release/README.md)

## 接入策略

当前策略：

1. 只实现路径存在性校验。
2. 只判断“静态仓库内路径是否存在”。
3. 不在第一版里过度推断 workflow 语义。

第一版最重要的是先拦住“明显失效路径”。

## 推荐输出方式

输出建议统一遵守：

- [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)

最小输出要求：

- 明确检查编号 `A05`
- 明确结果级别 `阻断`
- 明确缺失路径值
- 明确该路径来自哪个 workflow 文件、哪个字段
- 明确规则来源

## 推荐结果沉淀方式

首次接入或路径规则调整时，建议：

- 使用 [docs/reviews/templates/automation-check-report-template.md](../reviews/templates/automation-check-report-template.md) 记录试运行结果
- 若涉及发布、回滚或初始化流程变更，补 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

## 推荐验收标准

第三阶段当前已满足：

1. 能发现不存在的 `working-directory`
2. 能发现不存在的缓存路径或依赖路径
3. 能发现不存在的制品路径或脚本路径
4. 输出能明确指出来源 workflow 与字段
5. 对明显失效路径采取阻断策略

## 维护步骤

后续维护按以下顺序推进：

1. 先本地执行 `python .github/scripts/doc_guardrails.py`
2. 如有误报，优先调整静态路径识别规则，不放宽真实坏路径
3. 验证现有 workflow 全部通过
4. 继续保持阻断模式

## 与当前文档的关系

- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)
- 实施顺序：见 [docs/plans/harness-automation-implementation-brief.md](harness-automation-implementation-brief.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- workflow 入口：见 [.github/README.md](../../.github/README.md)

## 一句话结论

第三阶段已经作为主线 CI 的正式阻断护栏落地，维护重点是防止目录、脚本路径、缓存路径和模板路径再次偏离当前仓库事实。
