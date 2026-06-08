---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 文档治理收尾验证证据，记录文档代码对齐、链接、元数据、编码、API 摘要和剩余风险。
---

# 验证证据：文档治理收尾

## 基本信息

- 任务名称：HernessDemo 文档与当前代码事实收敛
- 验证时间：2026-06-08
- 验证人：Codex
- 任务类型：文档治理
- 变更范围：根 README、`AGENTS.md`、`docs/`、`deploy/release`、`deploy/observability`、文档导航和评审材料

## 验证目标

本次验证需要证明：

- 文档主线已经从旧 ProjectPilot、CallCenter、Flyway 默认叙事，收敛到当前 RuoYi-Vue-Plus 代码事实。
- 架构、设计、reference、评审、发布和 Harness Engineering 材料能互相导航。
- 文档中记录的前后端差异来自真实代码核对，没有把前端残留误写成已落地后端接口。
- 只改文档，不修改 `server/` 或 `web/` 业务代码。

本次不覆盖：

- 不修复 `web/src/api/workflow/definition/index.ts` 的 `definitionXml` 前端残留。
- 不修复 `web/src/api/monitor/cache/index.ts` 的缓存细分接口残留。
- 不执行后端 Maven 构建、前端 pnpm 构建或发布 workflow，因为本轮变更范围仅为文档。

## 代码事实核对

| 核对项 | 事实入口 | 结论 |
| --- | --- | --- |
| 后端主线 | [server/pom.xml](../../server/pom.xml)、[server/ruoyi-admin](../../server/ruoyi-admin)、[server/ruoyi-modules](../../server/ruoyi-modules) | 当前是 RuoYi-Vue-Plus 5.6.1 多模块后端，不是 ProjectPilot 或 CallCenter |
| 前端主线 | [web/package.json](../../web/package.json)、[web/src/views](../../web/src/views)、[web/src/api](../../web/src/api) | 当前已有 Vue 3/Vite 前端，不需要规划不存在的 `web/apps/projectpilot-web` |
| 数据库脚本 | [server/script/sql](../../server/script/sql) | 当前数据库结构由 SQL 初始化和 `update/` 升级脚本维护，不是 Flyway migration 体系 |
| 工作流接口差异 | [FlwDefinitionController.java](../../server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java)、[web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) | 后端存在 `/workflow/definition/xmlString/{id}`，前端仍保留 `/workflow/definition/definitionXml/{definitionId}` |
| 缓存监控接口差异 | [CacheController.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java)、[web/src/api/monitor/cache/index.ts](../../web/src/api/monitor/cache/index.ts) | 后端当前只暴露 `/monitor/cache`，前端仍保留缓存细分接口封装 |

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | Git 状态 | `git status --short --branch` | 通过 | 本轮验证开始前 `main...origin/main` 干净 |
| 2 | 变更范围 | `git diff --name-only` 与路径前缀检查 | 通过 | 确认没有 `server/`、`web/` 业务代码变更 |
| 3 | Markdown 差异空白 | `git diff --check` | 通过 | 未发现尾随空格或冲突标记 |
| 4 | 文档元数据 | 扫描 `docs/**/*.md` 的 `last_updated`、`status`、`owner`、`description` | 通过 | 根 README 仍按规范豁免 |
| 5 | UTF-8 编码 | 使用 Python 按 UTF-8 读取 README、AGENTS、docs、deploy Markdown | 通过 | 未发现编码错误 |
| 6 | Markdown 链接 | 扫描本地 Markdown 链接并验证目标存在 | 通过 | 未发现缺失链接 |
| 7 | API 摘要 | 解析 [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 并检查差异路径 | 通过 | `definitionXml` 和缓存细分残留未写入 API 摘要 |
| 8 | 历史事实误用 | 扫描 `ProjectPilot`、`CallCenter`、`services/callcenter-*`、`Flyway` | 通过 | 命中均为历史背景、禁止项或纠偏说明 |

## 基线对齐结果

- 技术基线：已对齐 JDK 17、Spring Boot 3.5.x、Spring Framework 6、Vue 3、TypeScript、Vite、pnpm。
- 数据库基线：已对齐当前 SQL 脚本体系；Flyway 只作为未落地或后续单独引入事项出现。
- 目录基线：已对齐 `server/`、`web/`、`docs/`、`deploy/`、`.github/workflows/`。
- 功能域基线：已通过 [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md) 收敛到 system、monitor、tool/gen、workflow、demo。
- Harness Engineering：已从概念说明收敛为代码地图、文档入口、评审清单、验证证据和自动化计划。

## 结果摘要

- 文档同步结果：通过。
- 文档导航结果：通过。
- 编码与链接结果：通过。
- API 摘要结果：通过。
- 发布或运行验证结果：未执行，原因是本轮没有修改运行代码、发布脚本或 workflow。

## 未覆盖风险

- `web/src/api/workflow/definition/index.ts` 的 `definitionXml` 前端残留仍需代码任务处理。
- `web/src/api/monitor/cache/index.ts` 的缓存细分接口残留仍需代码任务处理。
- `.github/workflows` 真实执行仍可能依赖 GitHub Environment、Secrets、远端主机和发布环境变量配置。
- 上游 RuoYi-Vue-Plus README 与本仓库治理文档语境不同，引用时仍需区分。

## 后续动作

- 文档治理任务到此结束，后续只需按常规维护规则增量更新。
- 如果继续执行代码修复，优先处理 [docs/plans/backlog.md](../plans/backlog.md) 中的 workflow definition 与 monitor cache 前后端差异。
- 如果继续推进 Harness 自动化，按 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md) 从 Markdown 元数据、链接和历史事实误用扫描开始。
