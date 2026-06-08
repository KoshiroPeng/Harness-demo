---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: ProjectPilot 的 Harness 自动化落地方案，定义文档校验、同步校验与分阶段推进路径。
---

# Harness 自动化落地方案

## 目标

本文档用于定义 ProjectPilot 在完成文档型 Harness 底座后，下一阶段应如何把高频规则逐步转化为自动化校验，减少纯人工执行的成本和遗漏风险。

本文档只定义“应该自动化什么、先后顺序是什么、每阶段的验收标准是什么”，不直接约束具体脚本实现方式。

## 当前判断

当前仓库已经具备：

- 统一规则入口：[AGENTS.md](../../AGENTS.md)
- 统一文档导航：[docs/README.md](../README.md)
- 文档元数据规范：[docs/conventions/document-metadata.md](document-metadata.md)
- 文档链接规范：[docs/conventions/document-links.md](document-links.md)
- 任务状态模板：[docs/plans/task-status-template.md](../plans/task-status-template.md)
- 验证证据模板：[docs/reviews/templates/verification-evidence-template.md](../reviews/templates/verification-evidence-template.md)

当前仓库仍缺少：

- 自动检查这些规则是否被遵守
- 自动提示高风险变更是否漏改配套文档
- 自动把“人工提醒”转成“机器先拦截、人工再判断”

## 自动化目标分层

### 第一层：文档治理自动化

目标是先把文档规则本身自动检查起来。

优先项：

- 内部 Markdown 文档元数据标头完整性校验
- 根目录 [README.md](../../README.md) 豁免规则校验
- 导航型文档 Markdown 链接写法校验
- 目录级入口文档存在性校验

### 第二层：文档同步自动化

目标是让高频变更自动触发“你是不是漏改文档”的提醒。

优先项：

- API 变更时，是否同步更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- 错误码变更时，是否同步更新 [docs/reference/error-codes.md](../reference/error-codes.md)
- 数据库迁移变更时，是否同步检查架构和发布相关文档
- 发布材料变更时，是否同步检查 [deploy/release/README.md](../../deploy/release/README.md)

### 第三层：任务闭环自动化

目标是让“任务状态”和“验证证据”逐步从可选模板变成可追踪动作。

优先项：

- 关键文档治理任务是否有状态记录
- 关键变更是否有验证证据模板输出
- PR 或交付说明中是否能追踪到验证结论

## 推荐推进顺序

### 阶段 1：先把最容易、最稳定的规则自动化

建议优先落地：

1. 元数据标头完整性检查
2. 根目录 `README.md` 豁免检查
3. 导航型文档 Markdown 链接检查

原因：

- 规则稳定
- 成本低
- 几乎不依赖业务代码
- 能立刻降低文档治理回退风险

阶段完成标准：

- 新增或修改内部 Markdown 文档时，若缺少 `last_updated/status/owner/description`，能被自动发现
- 根目录 `README.md` 不会被错误拦截
- 明确承担导航职责的文档，如果使用纯文本路径替代关键链接，能被自动发现

### 阶段 2：再做高频事实文档同步检查

建议第二批落地：

1. API 规范同步检查
2. 错误码文档同步检查
3. Flyway 相关文档联动检查

原因：

- 这些规则已经写进 [AGENTS.md](../../AGENTS.md)
- 它们属于高频遗漏项
- 一旦遗漏，影响开发、测试、评审和发布多个阶段

阶段完成标准：

- 改动接口相关实现时，系统能提示是否需要同步检查 `api-spec.yaml`
- 改动错误处理相关实现时，系统能提示是否需要同步检查错误码文档
- 新增迁移时，系统能提示是否需要同步检查架构或发布相关说明

### 阶段 3：最后做任务闭环证据化

建议第三批落地：

1. 状态模板使用提醒
2. 验证证据模板使用提醒
3. 评审输出模板完整性提醒

原因：

- 这部分规则最有价值，但主观性更强
- 适合在前两阶段稳定后逐步推进

阶段完成标准：

- 高风险任务至少能留下状态沉淀或验证证据入口
- 评审、自检、发布验证不再只留口头说明

## 建议检查项清单

### A. 元数据标头检查

检查范围：

- `docs/**/*.md`
- `deploy/**/*.md`
- `AGENTS.md`

检查规则：

- 必须有 `last_updated`
- 必须有 `status`
- 必须有 `owner`
- 必须有 `description`

豁免范围：

- 根目录 [README.md](../../README.md)

### B. 导航链接检查

检查范围：

- [AGENTS.md](../../AGENTS.md)
- [docs/README.md](../README.md)
- 各目录级 `README.md`
- 发布与运行手册

检查规则：

- 关键入口必须使用 Markdown 链接
- 不允许把关键导航长期退化为纯文本路径

### C. 文档同步检查

检查范围：

- 接口契约
- 错误码
- 数据库迁移
- 发布与回滚手册

检查规则：

- 变更实现时，至少触发对应文档同步检查提醒
- 如果本次变更明确涉及文档责任面，不能静默跳过

## 接入位置建议

文档只定义接入方向，不限定具体技术方案。建议未来实现时优先选择以下接入位置之一：

1. 本地预检查
2. CI 校验
3. PR 检查

建议顺序：

- 先本地可运行
- 再 CI 稳定化
- 最后再根据团队节奏决定是否做 PR 强提醒

## 风险提醒

- 不要一开始就把所有规则都做成强阻塞。
- 不要把仍然存在主观判断空间的评审规则全部机械化。
- 自动化的目标是“先拦明显错误”，不是“替代工程判断”。

## 一句话结论

ProjectPilot 下一阶段更接近完整 Harness Engineering 的关键，不是继续增加文档数量，而是：

> 把已经沉淀下来的高频规则，按“文档治理 -> 文档同步 -> 任务闭环”三层顺序，逐步转成自动检查能力。
