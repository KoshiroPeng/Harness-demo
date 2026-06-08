---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: 说明 Harness Engineering 在 HernessDemo 中的落地方向：真实代码地图、规则护栏、验证证据与自动化检查。
---

# Harness Engineering 落地说明

## 目标

本文档说明 Harness Engineering 在 HernessDemo 中的正确用法。它不是新业务范围，也不是大而全平台建设，而是一组让 AI 和人工协作者更稳定完成工程任务的支架。

## 当前结论

对本仓库而言，Harness Engineering 应落在一句话上：

> 用真实代码地图、清晰规则、可执行验证和自动化检查，让重构后的 RuoYi-Vue-Plus 系统持续保持文档与代码一致。

## 正确落点

### 1. 事实优先

所有架构、设计、发布和评审结论，必须先能回到真实文件验证：

- [docs/architecture/code-map.md](code-map.md)
- [server/pom.xml](../../server/pom.xml)
- [web/package.json](../../web/package.json)
- [server/script/sql](../../server/script/sql)
- [.github/workflows](../../.github/workflows)

旧文档中关于 `ProjectPilot`、`CallCenter`、`services/callcenter-server` 的说法，只能作为历史背景，不能作为当前事实。

### 2. 文档即导航

文档要帮助协作者快速找到下一步：

- [AGENTS.md](../../AGENTS.md)：规则入口。
- [docs/README.md](../README.md)：任务入口。
- [docs/architecture/code-map.md](code-map.md)：代码事实入口。
- [docs/conventions/task-startup-checklist.md](../conventions/task-startup-checklist.md)：任务启动入口。
- [docs/reviews/README.md](../reviews/README.md)：评审入口。
- [deploy/release/README.md](../../deploy/release/README.md)：发布支撑入口。

如果一个文档只是重复这些入口，或讲概念却不能指导任务，应删除、合并或改成索引。

### 3. 规则即护栏

当前高价值护栏包括：

- 中文与 UTF-8 规则。
- RuoYi-Vue-Plus 模块边界。
- JDK 17 / Spring Boot 3 / Vue 3 现行基线。
- `jakarta.*`、构造器注入、SLF4J、测试要求。
- SQL 脚本、API 文档、响应码文档同步要求。
- workflow 与发布脚本必须指向真实源码路径。

### 4. 验证即闭环

完成任务时，至少说明：

- 改了哪些文档或代码。
- 如何验证链接、编码、构建、测试或脚本。
- 哪些风险未覆盖。

高风险任务优先使用 [docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)。

### 5. 自动化优先级

下一阶段应优先把以下规则变成自动检查：

1. Markdown 元数据完整性。
2. Markdown 链接有效性。
3. `ProjectPilot`、`CallCenter`、`services/callcenter-server` 等历史事实误用扫描。
4. workflow 中源码路径是否存在。
5. SQL 脚本变更是否触发发布与数据文档检查。

自动化方案入口见 [docs/conventions/harness-automation-roadmap.md](../conventions/harness-automation-roadmap.md)。

## 偏航判断

符合当前 Harness Engineering 用法的改动通常具备：

- 直接降低代码和文档不一致风险。
- 能让下一位协作者更快定位真实入口。
- 能产生可执行验证或自动检查。
- 不新增脱离当前 RuoYi-Vue-Plus 代码事实的空泛概念。

应谨慎的改动通常具备：

- 继续扩写 ProjectPilot/CallCenter 过渡叙事。
- 新增很多目录或模板，但没有真实使用路径。
- 把发布治理、平台治理写成比当前系统本身更大的主线。
- 用未来目标结构替代当前代码事实。

## 一句话准则

在 HernessDemo 里，Harness Engineering 的正确方向不是“多写文档”，而是“让代码事实、协作规则和验证路径持续对齐”。
