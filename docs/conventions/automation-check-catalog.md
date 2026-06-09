---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化检查项目录，汇总文档治理、历史事实扫描、workflow 路径护栏与同步提醒的检查口径。
---

# 自动化检查项目录

## 目标

本文档用于把 HarnessBase 后续要接入的自动化检查，收敛成统一的检查项目录。

它回答四个问题：

1. 这个检查到底检查什么。
2. 这个检查的规则来源在哪里。
3. 这个检查应该阻断还是提醒。
4. 这个检查失败后应该给出什么样的提示。

## 使用方式

- 设计自动化脚本前，先查本文档，而不是凭印象重新定义规则。
- 若后续新增自动化检查，优先补充本文档，再补实现脚本或 CI。
- 若某项检查误报较多，应优先修改本文档中的适用范围、忽略规则或阻断级别说明。

## 检查项总览

| 检查编号 | 检查名称 | 默认级别 | 当前建议 |
| --- | --- | --- | --- |
| A01 | 治理型 Markdown 元数据标头检查 | 阻断 | 第一阶段优先落地 |
| A02 | Markdown 相对链接与锚点检查 | 阻断 | 第一阶段优先落地 |
| A03 | 已删除文档引用检查 | 阻断 | 可与 A02 合并实现 |
| A04 | 历史事实误用扫描 | 提醒 | 第二阶段落地 |
| A05 | workflow 路径存在性检查 | 阻断 | 第三阶段优先落地 |
| A06 | API 文档同步提醒 | 提醒 | 第四阶段落地 |
| A07 | 响应码与异常文档同步提醒 | 提醒 | 第四阶段落地 |
| A08 | SQL 与发布材料同步提醒 | 提醒 | 第四阶段落地 |

## A01：治理型 Markdown 元数据标头检查

检查目标：

- 治理型 Markdown 文档必须具备统一元数据标头。

规则来源：

- [AGENTS.md](../../AGENTS.md)
- [docs/conventions/document-metadata.md](document-metadata.md)

建议扫描范围：

- `AGENTS.md`
- `docs/**/*.md`
- `deploy/**/*.md`
- 承担导航、规则、模板、分流职责的目录级 `README.md`

建议忽略范围：

- 根目录 [README.md](../../README.md)
- `.gitee/` 等上游模板目录中的非治理型模板
- 资源目录占位 Markdown，例如 `package-info.md`
- 仅用于目录保留或外部展示的非治理型说明

校验要点：

- 文件头部存在 `---`
- 标头中包含 `last_updated`
- 标头中包含 `status`
- 标头中包含 `owner`
- 标头中包含 `description`

失败提示建议：

- 直接指出缺少哪个字段。
- 提供 [docs/conventions/document-metadata.md](document-metadata.md) 链接。

建议阻断级别：

- 阻断。

## A02：Markdown 相对链接与锚点检查

检查目标：

- 导航文档中的相对链接必须可以打开，锚点必须存在。

规则来源：

- [AGENTS.md](../../AGENTS.md)
- [docs/conventions/document-links.md](document-links.md)

建议扫描范围：

- `AGENTS.md`
- 根目录 [README.md](../../README.md)
- `docs/**/*.md`
- `deploy/**/*.md`
- `.github/README.md`
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

校验要点：

- 相对路径目标存在。
- 锚点在目标 Markdown 中真实存在。
- 允许跳过 `http`、`https`、`mailto` 和纯页内锚点以外的外部链接校验。

失败提示建议：

- 直接输出“来源文件 -> 缺失路径”或“来源文件 -> 缺失锚点”。

建议阻断级别：

- 阻断。

## A03：已删除文档引用检查

检查目标：

- 避免删除文档后导航仍然保留旧引用。

规则来源：

- [docs/README.md](../README.md)
- [docs/conventions/document-links.md](document-links.md)

实现建议：

- 可直接并入 A02。
- 如果链接目标文件不存在，即视为已删除文档引用。

失败提示建议：

- 给出失效引用出现的位置。
- 不需要单独新增复杂报错格式。

建议阻断级别：

- 阻断。

## A04：历史事实误用扫描

检查目标：

- 避免旧叙事重新进入当前文档事实。

规则来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)

建议扫描对象：

- 历史过渡产品名
- 旧行业业务叙事
- 不存在的旧源码路径
- 把 `Flyway` 写成当前已落地事实

建议忽略场景：

- 明确写着“历史背景”“禁止误用”“后续若引入”的说明
- 验证证据文档中的历史纠偏记录

失败提示建议：

- 提示命中词。
- 要求人工确认该命中是“误用”还是“历史说明”。

建议阻断级别：

- 先提醒，后续再评估是否对高置信规则升级阻断。

## A05：workflow 路径存在性检查

检查目标：

- 防止 `.github/workflows` 中重新引用不存在的目录、制品路径或脚本。

规则来源：

- [.github/README.md](../../.github/README.md)
- [deploy/release/README.md](../../deploy/release/README.md)
- [docs/architecture/code-map.md](../architecture/code-map.md)

建议扫描范围：

- `.github/workflows/*.yml`

建议校验项：

- `working-directory`
- `cache-dependency-path`
- 上传制品路径
- 发布脚本路径
- 关键模板路径

失败提示建议：

- 直接输出缺失路径值。
- 如果路径来自 workflow 字段，最好带上字段名。

建议阻断级别：

- 阻断。

## A06：API 文档同步提醒

检查目标：

- 当前后端 Controller、前端 API 客户端变更后，提醒同步参考文档。

规则来源：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)

建议触发范围：

- `server/**/controller/**/*.java`
- `web/src/api/**/*.ts`

提醒内容建议：

- 检查 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- 检查 [docs/reference/README.md](../reference/README.md)
- 若发现前后端不一致，先登记“已知差异”

建议阻断级别：

- 提醒。

## A07：响应码与异常文档同步提醒

检查目标：

- 异常处理、统一响应和 i18n 变更后，同步提醒检查错误码文档。

规则来源：

- [docs/reference/error-codes.md](../reference/error-codes.md)
- [docs/reference/README.md](../reference/README.md)

建议触发范围：

- `**/GlobalExceptionHandler.java`
- `**/SaTokenExceptionHandler.java`
- `**/R.java`
- `**/TableDataInfo.java`
- `server/**/i18n/**/*.properties`

提醒内容建议：

- 核对 [docs/reference/error-codes.md](../reference/error-codes.md)
- 若语义变化较大，补充验证证据

建议阻断级别：

- 提醒。

## A08：SQL 与发布材料同步提醒

检查目标：

- SQL 脚本变化时，提醒同步检查数据文档和发布验证材料。

规则来源：

- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)
- [deploy/release/README.md](../../deploy/release/README.md)

建议触发范围：

- `server/script/sql/**`

提醒内容建议：

- 核对初始化脚本与 `update/` 升级脚本
- 核对发布前检查与回滚影响
- 核对多数据库兼容脚本是否受影响

建议阻断级别：

- 提醒。

## 落地顺序建议

1. 先实现 A01、A02、A03。
2. 再实现 A05。
3. 再实现 A04。
4. 最后实现 A06、A07、A08。

## 维护规则

- 如果阻断级别变化，先更新本文档，再调整 CI。
- 如果某项检查需要新增忽略规则，必须把忽略原因写进本文档。
- 如果某项检查被删除，也要同步更新 [docs/plans/harness-automation-implementation-brief.md](../plans/harness-automation-implementation-brief.md) 和 [docs/conventions/harness-automation-roadmap.md](harness-automation-roadmap.md)。
- 检查输出文案建议统一遵守 [docs/conventions/automation-message-guidelines.md](automation-message-guidelines.md)。

## 一句话结论

后续实现自动化时，应先把检查项目录固定下来，再去写脚本和 workflow，这样才能避免“脚本一套、文档一套”。
