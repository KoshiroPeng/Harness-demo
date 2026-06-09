---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化检查项目录，统一定义文档护栏、历史事实扫描、workflow 路径校验和跨文档同步提醒。
---

# 自动化检查项目录

## 目标

本文档用于统一说明仓库内计划或已接入的自动化检查项，回答四个问题：

1. 这个检查检查什么
2. 这个检查的规则来源在哪里
3. 这个检查应该阻断还是提醒
4. 检查失败后要给出什么信息

## 使用方式

- 设计自动化脚本前，先更新本文档，而不是先写脚本再补规则。
- 如果某项检查误报较多，先修改本文档中的范围、豁免和输出口径，再调整实现。
- 新增检查项后，必须从 [docs/README.md](../README.md) 或 [docs/plans/automation-delivery-map.md](../plans/automation-delivery-map.md) 能直接进入。

## 检查总览

| 编号 | 检查项 | 默认级别 | 当前建议 |
| --- | --- | --- | --- |
| A01 | 治理型 Markdown 元数据标头检查 | 阻断 | 已优先落地 |
| A02 | Markdown 相对链接与锚点检查 | 阻断 | 已优先落地 |
| A03 | 已删除文档引用检查 | 阻断 | 已并入 A02 链接检查 |
| A04 | 历史事实误用扫描 | 提醒 | 已接入当前文档护栏脚本 |
| A05 | workflow 路径存在性检查 | 阻断 | 已接入当前文档护栏脚本 |
| A06 | API 文档同步提醒 | 提醒 | 作为第四阶段 |
| A07 | 错误码与异常文档同步提醒 | 提醒 | 作为第四阶段 |
| A08 | SQL 与发布材料同步提醒 | 提醒 | 作为第四阶段 |

## A01：治理型 Markdown 元数据标头检查

规则来源：

- [AGENTS.md](../../AGENTS.md)
- [docs/conventions/document-metadata.md](document-metadata.md)

建议扫描范围：

- `AGENTS.md`
- `docs/**/*.md`
- `deploy/**/*.md`
- 承担导航、规则、模板、流程职责的目录级 `README.md`

建议豁免范围：

- 根目录 [README.md](../../README.md)
- 上游模板目录中的非治理型模板
- 资源目录中的占位说明文件
- 仅用于目录保留的非治理型 Markdown

校验点：

- 文件头部存在 `---`
- 包含 `last_updated`
- 包含 `status`
- 包含 `owner`
- 包含 `description`

输出建议：

- 直接指出缺失字段
- 附带 [docs/conventions/document-metadata.md](document-metadata.md) 链接

级别建议：

- 阻断

## A02：Markdown 相对链接与锚点检查

规则来源：

- [AGENTS.md](../../AGENTS.md)
- [docs/conventions/document-links.md](document-links.md)

建议扫描范围：

- `AGENTS.md`
- [README.md](../../README.md)
- `docs/**/*.md`
- `deploy/**/*.md`
- [.github/README.md](../../.github/README.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

校验点：

- 相对路径目标存在
- Markdown 锚点真实存在
- 跳过 `http`、`https`、`mailto` 和纯页内引用之外的外部链接校验

输出建议：

- 直接输出“来源文件 -> 缺失路径”或“来源文件 -> 缺失锚点”

级别建议：

- 阻断

## A03：已删除文档引用检查

规则来源：

- [docs/README.md](../README.md)
- [docs/conventions/document-links.md](document-links.md)

实现状态：

- 已与 A02 合并处理
- 目标文件不存在时，直接视为已删除文档残留引用

级别建议：

- 阻断

## A04：历史事实误用扫描

规则来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)

建议扫描对象：

- 已失效的单体结构说法
- 已失效的源码路径
- 已失效的前端技术栈说法
- 已失效的 SQL 目录说法

当前高风险命中词示例：

- `RuoYi-Vue-Plus`
- `ruoyi-admin`
- `ruoyi-extend`
- `org.dromara`
- `server/script/sql`
- `Vue 3`
- `Vite`
- `Pinia`
- `TypeScript`
- `pnpm`

当前实现：

- 已接入 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 已随 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 执行
- 当前为提醒模式；命中项只提示人工复核，不作为阻断退出码
- 通过邻近上下文识别“历史、误用、纠偏、禁止、不是、当前不存在、命中词”等合法说明语境，避免把规则文档中的禁用词表误判为问题

建议忽略场景：

- 明确标注“历史背景”“纠偏说明”“禁止误用”的上下文
- 历史验证证据文档中的原始记录

输出建议：

- 提示命中词、文件路径和人工复核建议

级别建议：

- 先提醒，后续视误报情况评估是否升级

## A05：workflow 路径存在性检查

规则来源：

- [.github/README.md](../../.github/README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

建议扫描范围：

- `.github/workflows/*.yml`

建议校验项：

- `working-directory`
- `cache-dependency-path`
- 构建产物路径
- 发布脚本路径
- 模板与引用文件路径

当前实现：

- 已接入 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 已随 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml) 执行
- 只校验能静态判断的仓库内路径；动态表达式、远端路径和构建产物目录不在第一版阻断范围内

当前路径事实特别注意：

- 后端工作区根是 [server](../../server)
- 前端工作区根是 [web](../../web)
- SQL 事实目录是 [server/sql](../../server/sql)
- 当前不存在 `server/ruoyi-admin/target/ruoyi-admin.jar`

级别建议：

- 阻断

## A06：API 文档同步提醒

规则来源：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)

建议触发范围：

- `server/**/controller/**/*.java`
- `web/src/api/**/*.js`

提醒内容建议：

- 核对 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- 核对 [docs/reference/README.md](../reference/README.md)
- 如果发现前后端漂移，先记录事实再拆分修复任务

级别建议：

- 提醒

## A07：错误码与异常文档同步提醒

规则来源：

- [docs/reference/error-codes.md](../reference/error-codes.md)
- [docs/conventions/error-handling.md](error-handling.md)

建议触发范围：

- `**/GlobalExceptionHandler.java`
- `**/R.java`
- `**/TableDataInfo.java`
- `server/**/i18n/**/*.properties`

提醒内容建议：

- 核对 [docs/reference/error-codes.md](../reference/error-codes.md)
- 如语义有变化，补充验证证据

级别建议：

- 提醒

## A08：SQL 与发布材料同步提醒

规则来源：

- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [deploy/release/README.md](../../deploy/release/README.md)

建议触发范围：

- `server/sql/**`

提醒内容建议：

- 核对 SQL 脚本
- 核对发布前检查与回滚材料
- 核对多环境数据库兼容影响

级别建议：

- 提醒

## 落地顺序建议

1. 已完成 `A01`、`A02`、`A03`，并接入 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py) 与 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)。
2. 已完成 `A05`，并纳入当前文档与 workflow 护栏脚本。
3. 已完成 `A04`，并以提醒模式运行，后续只维护命中词和忽略语境。
4. 下一步实现 `A06`、`A07`、`A08`。

## 维护规则

- 如果阻断级别发生变化，先更新本文档，再调整 CI。
- 如果新增忽略规则，必须写明原因。
- 如果删除某项检查，也要同步更新 [docs/plans/harness-automation-implementation-brief.md](../plans/harness-automation-implementation-brief.md) 和 [docs/conventions/harness-automation-roadmap.md](harness-automation-roadmap.md)。
- 输出文案建议统一遵守 [docs/conventions/automation-message-guidelines.md](automation-message-guidelines.md)。
