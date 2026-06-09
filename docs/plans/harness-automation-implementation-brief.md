---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 自动化实施简报，将当前文档护栏、路径护栏和同步提醒拆成可分阶段落地的执行顺序。
---

# Harness 自动化实施简报

## 目标

本文档把当前自动化治理方向拆成可直接执行的实施顺序、验收口径和影响范围说明。

它服务于下一步“补脚本、补 CI、补检查”的工作，不替代规则文档本身。

## 为什么现在需要它

当前仓库已经完成了以下基础收口：

- 文档入口统一
- 真实代码地图收口
- 评审清单与验证模板补齐
- 开发、测试、发布、自动化入口可导航

当前第一阶段文档结构类硬校验、第二阶段历史事实误用提醒和第三阶段 workflow 路径护栏已经落地，仍然缺少的是：

- 后续阶段哪些自动化检查先做，哪些后做
- 后续每类检查依赖哪些事实来源
- A06-A08 检查失败后要如何给出高可读提示
- 哪些适合直接阻断，哪些应先以提醒方式落地

## 实施范围

本实施简报只覆盖以下自动化检查：

1. Markdown 元数据标头检查
2. Markdown 链接与锚点检查
3. 历史事实误用扫描
4. workflow 路径存在性检查
5. API、错误码、SQL 与发布材料的文档同步提醒

暂不覆盖：

1. 复杂语义级代码审查自动化
2. 自动修复文档或代码的 agent 工作流
3. 发布权限、Secrets 或远端主机配置校验

## 推荐落地顺序

### 第一阶段：文档结构类硬校验

当前状态：已落地。

目标：

- 先拦住最稳定、误报最低的问题

建议检查：

- 治理型 Markdown 是否带统一标头
- 根目录 [README.md](../../README.md) 是否按豁免规则排除
- Markdown 相对链接和锚点是否存在

事实来源：

- [docs/conventions/document-metadata.md](../conventions/document-metadata.md)
- [docs/conventions/document-links.md](../conventions/document-links.md)

验收标准：

- 关键入口文档全部通过
- 模板目录、占位说明和非治理型文件不会被误判

执行建议：

- 当前脚本入口是 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 当前 CI 入口是 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)
- 该阶段应继续保持阻断模式

### 第二阶段：历史事实误用扫描

当前状态：已落地，提醒模式运行。

目标：

- 防止旧结构重新写回当前文档主线

建议扫描：

- 已失效的单体结构叙事
- 已失效的路径和包名
- 已失效的前端技术栈叙事

事实来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [docs/architecture/target-technology-baseline.md](../architecture/target-technology-baseline.md)
- [AGENTS.md](../../AGENTS.md)

执行建议：

- 当前脚本入口是 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 当前 CI 入口是 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)
- 该阶段继续以提醒模式运行
- 逐步维护命中词和忽略语境，避免误伤历史证据文档

### 第三阶段：workflow 路径护栏

当前状态：已落地。

目标：

- 防止 CI、发布或回滚继续引用错误目录和错误制品路径

建议检查：

- `.github/workflows/*.yml` 中的 `working-directory`
- `cache-dependency-path`
- 构建产物路径
- 脚本路径

事实来源：

- [docs/architecture/code-map.md](../architecture/code-map.md)
- [.github/README.md](../../.github/README.md)
- [server/README.md](../../server/README.md)
- [web/README.md](../../web/README.md)

当前必须坚持的真实路径：

- 后端根目录是 [server](../../server)
- 前端根目录是 [web](../../web)
- SQL 目录是 [server/sql](../../server/sql)

执行状态：

- 当前脚本入口是 [.github/scripts/doc_guardrails.py](../../.github/scripts/doc_guardrails.py)
- 当前 CI 入口是 [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)
- 该阶段已按阻断模式接入

### 第四阶段：跨文档同步提醒

目标：

- 当 API、错误码、SQL 或发布材料相关代码变化时，提醒不要漏改文档

建议提醒：

- `web/src/api/**/*.js` 或后端 Controller 变化时，提醒核对 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- `R.java`、`TableDataInfo.java`、异常处理器或 i18n 变化时，提醒核对 [docs/reference/error-codes.md](../reference/error-codes.md)
- [server/sql](../../server/sql) 变化时，提醒核对 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md) 和发布材料

执行建议：

- 先做“提醒到位”
- 不要求一开始就自动判断文档是否改够

## 推荐实施节奏

1. 已完成：第一阶段文档结构类硬校验，并接入 CI
2. 已完成：第三阶段 workflow 路径检查，并接入当前文档护栏脚本
3. 已完成：第二阶段关键词扫描，以非阻断提醒模式运行
4. 下一步：完成第四阶段同步提醒

如果资源有限，最小可用顺序是：

1. 保持标头检查和链接检查稳定
2. 保持 workflow 路径检查稳定
3. 保持历史事实误用提醒稳定

## 与当前文档的关系

- 自动化总导航：见 [docs/plans/automation-delivery-map.md](automation-delivery-map.md)
- 检查定义：见 [docs/conventions/automation-check-catalog.md](../conventions/automation-check-catalog.md)
- 输出规范：见 [docs/conventions/automation-message-guidelines.md](../conventions/automation-message-guidelines.md)
- 阶段验收：见 [docs/plans/automation-phase-acceptance-checklist.md](automation-phase-acceptance-checklist.md)
- 后续事项：见 [docs/plans/backlog.md](backlog.md)

## 完成判定

当以下条件满足时，可认为当前自动化治理进入“第一轮可用”状态：

- 文档元数据与链接检查已接入并持续通过
- workflow 路径检查已接入并持续通过
- 历史事实误用扫描具备稳定提醒能力
- API、错误码、SQL 相关同步提醒形成最小闭环
