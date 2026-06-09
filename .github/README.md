---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase GitHub 工作流入口，汇总 CI、发布、回滚与远端主机初始化 workflow 的职责、输入与联读文档。
---

# GitHub 工作流入口

## 目标

本文档作为 HarnessBase 的 GitHub Actions 入口，帮助开发者和 AI 协作者快速确认当前有哪些 workflow、分别负责什么、执行前要核对哪些脚本和环境变量。

当前 workflow 真实文件位于 [workflows](workflows)。如果文档与 workflow YAML 冲突，以真实 YAML、[deploy/release](../deploy/release) 脚本和仓库代码路径为准。

## 快速导航

- [AGENTS.md](../AGENTS.md)：仓库级协作规则与 Git 提交要求
- [docs/README.md](../docs/README.md)：统一文档导航入口
- [docs/plans/phase1-doc-check-ci-brief.md](../docs/plans/phase1-doc-check-ci-brief.md)：第一阶段文档结构类检查 CI 接入说明
- [deploy/release/README.md](../deploy/release/README.md)：发布脚本说明
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)：环境变量与密钥模板
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)：发布与回滚检查清单

## 当前 workflow 一览

| Workflow | 文件 | 作用 |
| --- | --- | --- |
| CI / 护栏校验 | [agent-guardrails.yml](workflows/agent-guardrails.yml) | 执行后端构建、前端构建与基础制品上传 |
| 服务发布 | [server-release.yml](workflows/server-release.yml) | 构建发布包、生成发布计划、执行 SSH 部署、发布后验证 |
| 服务回滚 | [server-rollback.yml](workflows/server-rollback.yml) | 远端回滚指定制品并执行回滚后验证 |
| 远端初始化 | [bootstrap-remote-host.yml](workflows/bootstrap-remote-host.yml) | 初始化远端目录、环境文件与 systemd 服务骨架 |

## 运行前必须确认

1. workflow 中 `working-directory`、缓存路径和制品路径仍指向真实 [server](../server)、[web](../web) 与 [deploy](../deploy)。
2. 发布与回滚脚本入口仍是 [deploy/release](../deploy/release) 中的当前脚本，而不是历史路径。
3. 远端环境变量、Secrets 和服务名与 [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md) 保持一致。
4. 如果涉及 SQL、接口或响应码变化，相关文档和验证清单已经同步更新。

## 典型使用场景

### 做 PR 或主分支构建校验

优先看：

- [workflows/agent-guardrails.yml](workflows/agent-guardrails.yml)
- [server/README.md](../server/README.md)
- [web/README.md](../web/README.md)

重点关注：

- 文档结构类检查是否作为前置阻断门禁接入
- 后端 `mvn -B -DskipTests package`
- 前端 `pnpm install --frozen-lockfile` 与 `pnpm build:prod`
- 制品上传路径是否仍存在

### 做正式发布

优先看：

- [workflows/server-release.yml](workflows/server-release.yml)
- [deploy/release/README.md](../deploy/release/README.md)
- [deploy/release/release-checklist.md](../deploy/release/release-checklist.md)
- [deploy/release/environment-variable-template.md](../deploy/release/environment-variable-template.md)

重点关注：

- `server/ruoyi-admin/target/ruoyi-admin.jar` 是否仍为实际制品
- SSH 发布脚本与服务模板是否匹配当前服务名语境
- 发布后验证地址是否可访问 `/actuator/health` 与 `/actuator/prometheus`

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
- 若 workflow 语义变化会影响开发、测试、发布或回滚流程，必须同步更新 [AGENTS.md](../AGENTS.md) 或对应任务文档。
