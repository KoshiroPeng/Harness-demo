---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 后续待办列表，覆盖文档代码对齐、workflow 修正、SQL 治理、发布支撑与 Harness 自动化。
---

# Backlog

## P0：历史残留清理

- 修正 `.github/workflows` 中 `services/callcenter-server` 路径，改为真实 [server](../../server) 构建入口。
- 清理或删除空的 [services](../../services) 历史目录。
- 统一发布脚本中的 `herness-demo`、`callcenter`、`ruoyi-admin` 服务名和制品名语境。
- 持续扫描并清理文档中残留的 ProjectPilot 项目管理、搜索、计费和 CallCenter 事实误用。

## P1：文档事实同步

- 继续补齐 RuoYi-Vue-Plus system、monitor、tool/gen、workflow、demo 的功能设计说明。
- 持续校准 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)，确保仓库级 API 摘要与 SpringDoc 和真实 Controller 保持一致。
- 将 [docs/reference/error-codes.md](../reference/error-codes.md) 与当前 `R`、`HttpStatus`、i18n 消息、全局异常处理对齐。
- 为 SQL 脚本更新补充更明确的变更模板和验证清单。

## P2：代码与质量硬化

- 修复或标记历史启动输出中的 `System.out.println`，避免与新增代码规则冲突。
- 按风险补齐后端单元测试和前端 Vitest 覆盖。
- 检查字段级 `@Autowired`、`javax.*`、裸 HTTP 客户端和直接跨层调用。
- 对过长 Java 文件和方法做分阶段收敛。

## P3：发布与观测

- 修正 GitHub Actions 构建、发布、回滚 workflow。
- 将发布制品路径统一到 `server/ruoyi-admin/target/ruoyi-admin.jar` 或实际构建产物。
- 校验 [deploy/observability](../../deploy/observability) 与 Actuator 配置是否匹配。
- 为 SQL 升级脚本补充发布前检查和回滚策略说明。

## P4：Harness 自动化

- 增加 Markdown 元数据检查。
- 增加 Markdown 链接检查。
- 增加历史事实误用扫描。
- 增加 workflow 路径存在性检查。
- 增加 SQL 变更触发文档同步提醒。

## Backlog 维护规则

- 每个任务进入迭代前必须有明确验收标准。
- 涉及架构或边界变化的任务必须同步 [docs/architecture/code-map.md](../architecture/code-map.md) 与 [docs/architecture/README.md](../architecture/README.md)。
- 涉及 API 的任务必须同步 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 涉及响应码或错误消息的任务必须同步 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及 SQL 的任务必须同步 [server/script/sql](../../server/script/sql) 与发布检查材料。
