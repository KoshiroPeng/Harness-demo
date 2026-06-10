---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase GitHub 工作流入口，汇总当前微服务 CI、发布、回滚与远端主机初始化 workflow 的职责、输入与联读文档。
---

# GitHub 工作流入口

## 目标

本文档作为 HarnessBase 的 GitHub Actions 入口，帮助开发者和 AI 协作者快速确认当前有哪些 workflow、分别负责什么、执行前要核对哪些脚本和环境变量。

当前 workflow 真实文件位于 [workflows](workflows)。如果文档与 workflow YAML 冲突，以真实 YAML、[deploy/release](../deploy/release) 脚本和仓库代码路径为准。

## 快速导航

- [AGENTS.md](../AGENTS.md)：仓库级协作规则与 Git 提交要求
- [docs/README.md](../docs/README.md)：统一文档导航入口
- [docs/conventions/automation-check-catalog.md](../docs/conventions/automation-check-catalog.md)：自动化检查规则入口
- [deploy/release/README.md](../deploy/release/README.md)：发布脚本说明
- [deploy/compose/README.md](../deploy/compose/README.md)：docker-compose 部署入口
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)：环境变量与密钥模板
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)：发布与回滚检查清单

## 当前 workflow 一览

| Workflow | 文件 | 作用 |
| --- | --- | --- |
| CI / 护栏校验 | [agent-guardrails.yml](workflows/agent-guardrails.yml) | 先执行文档、历史事实和 workflow 护栏检查，再执行后端 Maven 构建、前端 npm 构建与构建产物上传 |
| 服务发布 | [server-release.yml](workflows/server-release.yml) | 手动指定微服务模块，构建目标模块制品、生成发布计划、执行 SSH 部署、发布后验证 |
| 服务回滚 | [server-rollback.yml](workflows/server-rollback.yml) | 按服务级制品名称回滚远端当前版本并执行回滚后验证 |
| 远端初始化 | [bootstrap-remote-host.yml](workflows/bootstrap-remote-host.yml) | 初始化远端目录、环境文件与 systemd 服务骨架 |
| Compose 发布 | [compose-release.yml](workflows/compose-release.yml) | 构建 compose 所需制品、上传部署包，并在远端执行 docker-compose 编排部署 |
| Compose 回滚 | [compose-rollback.yml](workflows/compose-rollback.yml) | 按远端 compose 快照恢复编排文件与环境配置，并重新拉起整套服务 |
| Compose 数据操作 | [compose-data-ops.yml](workflows/compose-data-ops.yml) | 对 compose 数据目录执行备份或恢复，并在恢复后重新拉起服务 |

当前 GitHub Actions 现在同时覆盖两条主线：

- 模块级 SSH 发布、回滚与主机初始化
- 整套微服务 compose 发布

## 最近一次本地基线验证

截至 2026-06-09，当前 workflow 依赖的本地执行链已经按真实项目结构完成了一轮人工验证：

- 后端在 [server](../server) 下执行 `mvn -B -DskipTests package`，结果为 `BUILD SUCCESS`。
- 前端在 [web](../web) 下执行 `npm.cmd install` 与 `npm.cmd run build:prod`，结果均成功。
- 前端生产构建存在体积告警，但没有阻塞构建完成；当前问题属于性能治理范围，不属于执行链断裂。

这意味着当前 CI 文档口径已经稳定在“微服务后端 + npm 前端构建”的执行主线上。

## 运行前必须确认

1. workflow 中的 `working-directory`、缓存路径和制品路径仍指向真实 [server](../server)、[web](../web) 与 [deploy](../deploy)。
2. 发布与回滚脚本入口仍是 [deploy/release](../deploy/release) 中的当前脚本。
3. 远端环境变量、Secrets 和服务名与 [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md) 保持一致。
4. 如果涉及 SQL、接口或响应码变化，相关文档和验证清单已经同步更新。
5. 如果本次目标是整套微服务容器化交付，先核对 [deploy/compose/README.md](../deploy/compose/README.md) 是否比当前 workflow 更符合场景。

## 典型使用场景

### 做 PR 或主分支构建校验

优先看：

- [workflows/agent-guardrails.yml](workflows/agent-guardrails.yml)
- [server/README.md](../server/README.md)
- [web/README.md](../web/README.md)

重点关注：

- `python .github/scripts/doc_guardrails.py` 是否作为最前置文档、历史事实、workflow 和跨文档同步提醒门禁执行
- 后端 `mvn -B -DskipTests package`
- 前端 `npm install` 与 `npm run build:prod`
- 当前 workflow 是否已经按 Vue 2 / npm 前端事实执行
- 前端构建若出现告警，先区分是 `warning` 还是真实 `error`，不要把体积告警误判成构建失败

### 做正式发布

优先看：

- [workflows/server-release.yml](workflows/server-release.yml)
- [deploy/release/README.md](../deploy/release/README.md)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)

重点关注：

- 当前 workflow 是否按手动选择的微服务模块制品组织发布包
- 发布输入中的 `target_module`、`APP_SERVICE_NAME` 与远端部署目录是否匹配当前目标服务
- 发布后验证地址是否可访问 `/actuator/health` 或其他真实健康检查入口
- `target_module` 应直接对应 Maven 模块路径，例如 `ruoyi-auth`、`ruoyi-gateway`、`ruoyi-modules/ruoyi-system`、`ruoyi-visual/ruoyi-monitor`

### 做整套 compose 发布

优先看：

- [workflows/compose-release.yml](workflows/compose-release.yml)
- [deploy/compose/README.md](../deploy/compose/README.md)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)

重点关注：

- 当前 workflow 使用的是 `.env.example` 还是 `.env.prod.example`
- 远端 `APP_DEPLOY_DIR` 是否适合作为 compose 部署目录，推荐与单服务 SSH 发布目录分开，例如 `/opt/harness-base-compose`
- workflow artifact 中是否已经包含当前版本的 Jar 与前端 dist
- 远端主机是否已安装 Docker Engine 与 Docker Compose Plugin

### 做 compose 回滚

优先看：

- [workflows/compose-rollback.yml](workflows/compose-rollback.yml)
- [deploy/compose/README.md](../deploy/compose/README.md)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

重点关注：

- 输入的 `rollback_backup` 是否对应远端已有快照目录
- 回滚快照是否覆盖了本次需要恢复的 compose 配置与环境文件
- 回滚后是否重新执行了 compose 最小验证

### 做 compose 数据备份或恢复

优先看：

- [workflows/compose-data-ops.yml](workflows/compose-data-ops.yml)
- [deploy/compose/README.md](../deploy/compose/README.md)
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)

重点关注：

- 当前执行的是 `backup` 还是 `restore`
- `data_backup_label` 是否和远端目录中的实际归档一致
- `COMPOSE_FILE_UPLOAD_PATH` 是否正确指向上传目录宿主机路径
- 当前操作目标是 `APP_DEPLOY_DIR/data-backups/` 下的数据归档，而不是 `APP_DEPLOY_DIR/backups/` 下的编排快照

### 做回滚

优先看：

- [workflows/server-rollback.yml](workflows/server-rollback.yml)
- [deploy/release/rollback-via-ssh.sh](../deploy/release/rollback-via-ssh.sh)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)

重点关注：

- 回滚制品名是否与远端制品目录一致
- 回滚后验证地址是否仍然有效

### 做远端主机初始化

优先看：

- [workflows/bootstrap-remote-host.yml](workflows/bootstrap-remote-host.yml)
- [deploy/release/bootstrap-remote-host.sh](../deploy/release/bootstrap-remote-host.sh)
- [deploy/release/harness-base.service.template](../deploy/release/harness-base.service.template)

重点关注：

- systemd 服务名与部署目录是否统一
- 初始化脚本是否仍引用当前模板和变量名

## 维护规则

- 新增或删除 workflow 后，必须同步更新本文档和 [docs/README.md](../docs/README.md)。
- 调整 workflow 中的源码路径、制品路径、缓存路径、环境变量或服务名时，必须同步更新 [deploy/release/README.md](../deploy/release/README.md)。
- 如果后续新增 compose 相关 workflow，必须同步更新 [deploy/compose/README.md](../deploy/compose/README.md) 与 [docs/README.md](../docs/README.md)。
- 如果 workflow 语义变化会影响开发、测试、发布或回滚流程，必须同步更新 [AGENTS.md](../AGENTS.md) 或对应任务文档。
