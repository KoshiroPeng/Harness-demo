---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase Harness 自动化落地方案，定义文档校验、历史事实误用扫描、workflow 路径检查与 SQL 同步检查。
---

# Harness 自动化落地方案

## 目标

本文档定义 HarnessBase 如何把高频协作规则转成自动化检查，减少文档和代码再次错位。

## 当前状态

当前仓库已经具备：

- 统一规则入口：[AGENTS.md](../../AGENTS.md)
- 统一文档导航：[docs/README.md](../README.md)
- 当前代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)
- 第一阶段文档护栏脚本：[.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- CI 文档护栏入口：[.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)

第一阶段已经落地：

- A01：治理型 Markdown 元数据标头检查
- A02：Markdown 相对链接与锚点检查
- A03：已删除文档引用检查，已并入 A02 链接检查处理
- A04：历史事实误用扫描，当前以提醒模式运行
- A05：workflow 路径存在性检查

当前仓库仍缺少：

- A06-A08：自动提醒 SQL、API、响应码、发布材料的同步关系

## 推荐推进顺序

1. 维护并持续验证 A01-A05 文档、历史事实和 workflow 护栏。
2. 最后补 A06-A08 API、响应码、SQL、发布材料的同步提醒。

## 当前最小验证命令

```bash
python .github/scripts/doc_guardrails.py
```

该命令当前应输出 A01/A02/A03/A04/A05 通过。若失败，先修复元数据、相对链接、锚点或 workflow 路径；若出现 A04 提醒，先人工复核是否属于历史事实误用，再继续做后端、前端或发布相关验证。
