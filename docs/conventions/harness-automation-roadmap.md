---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo Harness 自动化落地方案，定义文档校验、历史事实误用扫描、workflow 路径检查与 SQL 同步检查。
---

# Harness 自动化落地方案

## 目标

本文档定义 HernessDemo 下一阶段如何把高频协作规则转成自动化检查，减少文档和代码再次错位。

## 当前判断

当前仓库已经具备：

- 统一规则入口：[AGENTS.md](../../AGENTS.md)
- 统一文档导航：[docs/README.md](../README.md)
- 当前代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)
- 文档元数据规范：[docs/conventions/document-metadata.md](document-metadata.md)
- 文档链接规范：[docs/conventions/document-links.md](document-links.md)
- 验证证据模板：[docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

当前仓库仍缺少：

- 自动检查 Markdown 元数据和链接。
- 自动发现旧 ProjectPilot/CallCenter 叙事误用。
- 自动发现 workflow 指向不存在源码路径。
- 自动提醒 SQL、API、响应码、发布材料的同步关系。

## 自动化目标分层

### 第一层：文档治理自动化

优先项：

- 内部 Markdown 文档元数据标头完整性校验。
- 根目录 [README.md](../../README.md) 豁免规则校验。
- Markdown 链接存在性校验。
- 已删除文档引用检查。

### 第二层：历史事实误用扫描

优先项：

- 扫描 `ProjectPilot` 是否被当成当前产品事实。
- 扫描 `CallCenter` 是否被当成当前代码或业务来源。
- 扫描 `services/callcenter-server` 是否被当成真实源码入口。
- 扫描 `Flyway` 是否被写成已落地数据库迁移体系。

### 第三层：工程同步检查

优先项：

- workflow 中的 `working-directory`、`cache-dependency-path`、artifact 路径必须存在。
- API Controller 或前端 API 变更时，提醒检查 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- `GlobalExceptionHandler`、`R`、i18n 消息变更时，提醒检查 [docs/reference/error-codes.md](../reference/error-codes.md)。
- [server/script/sql](../../server/script/sql) 变更时，提醒检查发布清单和数据脚本文档。

## 推荐推进顺序

1. 先做 Markdown 元数据和链接检查。
2. 再做历史事实误用扫描。
3. 再做 workflow 路径存在性检查。
4. 最后做 API、响应码、SQL、发布材料的同步提醒。

## 风险提醒

- 不要一开始就把所有提醒设为强阻塞。
- 对仍需要人工判断的评审项，先做提示，不做机械拦截。
- 自动化目标是拦截明显错位，不替代工程判断。

## 一句话结论

HernessDemo 下一阶段更接近完整 Harness Engineering 的关键，是把“真实代码地图 + 文档规则 + 验证证据”变成可运行检查。
