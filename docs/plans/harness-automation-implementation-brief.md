---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化检查实施简报，将文档治理和路径护栏拆成可分阶段落地的执行计划。
---

# Harness 自动化检查实施简报

## 目标

本文档把 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) 中的方向性目标，进一步收敛成可直接执行的实施顺序、验收口径和影响范围说明。

它服务于下一阶段“允许补脚本、补 CI、补检查”的任务，不替代当前文档规则本身。

## 为什么现在需要它

当前仓库已经完成：

- 文档入口统一。
- 真实代码地图收敛。
- 评审清单和验证证据模板补齐。
- 发布、workflow、reference、设计、规范入口可直接导航。

当前仓库仍缺：

- 哪些自动检查先做，哪些后做。
- 每一类检查的事实来源是什么。
- 检查失败后应该提示什么，而不是只知道“报错”。
- 哪些检查适合先做提醒，哪些可以直接阻断。

## 实施范围

本实施简报只覆盖以下自动化检查：

1. Markdown 元数据标头检查。
2. Markdown 链接与锚点检查。
3. 历史事实误用扫描。
4. workflow 路径存在性检查。
5. SQL、API、响应码与发布材料的文档同步提醒。

本实施简报暂不覆盖：

1. 业务代码静态分析替代方案。
2. 复杂语义级评审自动化。
3. 自动修复文档或代码的 agent 工作流。
4. 发布权限、Secrets、远端主机配置校验。

## 推荐落地顺序

### 第一阶段：文档结构类硬校验

目标：

- 先拦住最确定、误报最低的问题。

建议检查：

- 治理型 Markdown 文档是否带有 `last_updated`、`status`、`owner`、`description` 标头。
- 根目录 [README.md](../../README.md) 是否按豁免规则排除。
- Markdown 相对链接和锚点是否存在。

事实来源：

- [docs/conventions/document-metadata.md](../conventions/document-metadata.md)
- [docs/conventions/document-links.md](../conventions/document-links.md)

验收标准：

- 关键入口文档全部通过。
- 不把 `.gitee/` 模板、资源目录占位 `md`、`package-info.md` 误判为治理文档。

执行方式建议：

- 本地脚本先行。
- GitHub Actions 中先以失败即阻断的方式启用，因为这类错误高度确定。

### 第二阶段：历史事实误用扫描

目标：

- 防止文档重新写回已经被纠偏掉的旧事实。

建议扫描：

- 旧过渡产品叙事。
- 旧行业业务叙事。
- 不存在的旧源码路径。
- 把 `Flyway` 写成当前已落地迁移体系。

事实来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [AGENTS.md](../../AGENTS.md)

验收标准：

- 命中项必须能区分“禁止误用”和“历史背景说明”。
- 先以提示模式运行，不要一开始就阻断所有提交。

执行方式建议：

- 先做关键词扫描。
- 再逐步收敛忽略规则，避免误伤验证证据和历史说明文档。

### 第三阶段：workflow 路径护栏

目标：

- 防止 CI、发布、回滚继续引用错误目录。

建议检查：

- `.github/workflows/*.yml` 中的 `working-directory` 是否存在。
- 关键缓存路径、制品路径、脚本路径是否存在。
- 发布相关 workflow 是否仍指向 [server](../../server)、[web](../../web)、[deploy](../../deploy) 当前结构。

事实来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [.github/README.md](../../.github/README.md)
- [deploy/release/README.md](../../deploy/release/README.md)

验收标准：

- 能发现明显不存在的路径。
- 能发现把旧源码路径重新写回 workflow 的情况。

执行方式建议：

- 先做存在性校验。
- 不做对 workflow 语义的过度推断。

### 第四阶段：跨文档同步提醒

目标：

- 当 API、SQL、响应码、发布材料变化时，提醒开发者不要漏改文档。

建议提醒：

- `web/src/api` 或后端 Controller 变化时，提醒核对 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 和 [docs/reference/README.md](../reference/README.md)。
- `GlobalExceptionHandler`、`SaTokenExceptionHandler`、`R`、`TableDataInfo` 或 i18n 消息变化时，提醒核对 [docs/reference/error-codes.md](../reference/error-codes.md)。
- [server/script/sql](../../server/script/sql) 变化时，提醒核对 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 和 [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)。

事实来源：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/error-codes.md](../reference/error-codes.md)
- [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)
- [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)

验收标准：

- 先做到“提醒到位”，不要求一开始就自动判断文档是否改得足够。
- 提醒内容必须带具体文档链接，不能只报抽象名称。

执行方式建议：

- 先通过变更路径触发提醒。
- 后续再视误报情况决定是否升级为阻断。

## 推荐实施节奏

1. 第一周：完成第一阶段，并接入 CI。
2. 第二周：完成第二阶段关键词扫描，先用非阻断模式运行。
3. 第三周：完成第三阶段 workflow 路径检查。
4. 第四周：完成第四阶段文档同步提醒。

如果资源有限，最小可用顺序是：

1. 元数据检查。
2. 链接检查。
3. workflow 路径检查。

## 与当前文档的关系

- 规则来源：见 [AGENTS.md](../../AGENTS.md) 和 [docs/conventions/README.md](../conventions/README.md)。
- 自动化方向：见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)。
- 检查项目录：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)。
- 下一步任务拆分：见 [docs/plans/backlog.md](backlog.md)。
- 任务执行记录：跨阶段实施时，建议配合 [docs/plans/task-status-template.md](task-status-template.md)。
- 验证沉淀：落地后建议使用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md) 记录结果。

## 完成判定

当以下条件满足时，可认为 HarnessBase 的文档治理自动化进入“第一轮可用”状态：

- 文档元数据与链接检查已接入。
- workflow 路径检查已接入。
- 历史事实误用扫描已具备稳定提示能力。
- API、SQL、响应码相关的文档同步提醒已形成最小闭环。

## 一句话结论

下一步不是继续扩写规则，而是把现有高频规则按“硬校验优先、提醒后置、误报可控”的方式接进自动化。
