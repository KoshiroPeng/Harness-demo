---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 发布支撑目录入口，汇总当前微服务发布、回滚、初始化、验证脚本和 workflow 路径护栏。
---

# 发布脚本说明

本目录承载 HarnessBase 的发布编排辅助脚本，目标是把发布计划、发布后验证、远端部署和回滚检查沉淀为可执行资产。

## 当前状态

当前发布脚本本身位于 [deploy/release](.)，GitHub Actions 位于 [.github/workflows](../../.github/workflows)。真实发布前必须确认 workflow、脚本、制品路径和环境变量仍然指向当前代码入口。

如果需要先了解 workflow 职责分工，再回来看脚本细节，优先阅读 [.github/README.md](../../.github/README.md)。

真实后端源码入口是 [server](../../server)。当前仓库已切换为若依微服务结构，发布时不应再默认假设只有单一 `ruoyi-admin` 制品。

截至 2026-06-09，和发布前置验证直接相关的本地基线已经补齐：

- [server](../../server) 下 `mvn -B -DskipTests package` 已通过。
- [web](../../web) 下 `npm.cmd install` 与 `npm.cmd run build:prod` 已通过。
- 当前应把风险识别重点放在“远端部署参数是否与目标服务一致”，而不是继续沿用历史单体制品假设。

## 当前文件说明

- [render-release-plan.sh](render-release-plan.sh)：根据环境、版本号和 `dry-run` 标记生成发布计划。
- [verify-release.sh](verify-release.sh)：对目标环境执行最小发布后验证，重点检查健康检查和指标端点。
- [deploy-via-ssh.sh](deploy-via-ssh.sh)：通过 SSH 与 SCP 执行最小远端发布骨架。
- [rollback-via-ssh.sh](rollback-via-ssh.sh)：通过 SSH 执行指定版本制品的远端回滚。
- [harness-base.service.template](harness-base.service.template)：当前默认 systemd 服务模板，供正式环境标准化托管时参考。
- [bootstrap-remote-host.sh](bootstrap-remote-host.sh)：首次初始化远端主机目录、环境文件与 systemd 服务。
- [release-checklist.md](release-checklist.md)：发布、验证与回滚前后的最小检查清单。
- [environment-variable-template.md](environment-variable-template.md)：环境变量和密钥准备模板。

## Workflow 路径护栏

以下 workflow 发布前需要核对：

- [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)
- [.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)
- [.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml)
- [.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml)

重点检查：

- `working-directory` 是否指向 [server](../../server)。
- Maven cache path 是否指向 [server/pom.xml](../../server/pom.xml)。
- Jar 查找路径是否匹配当前真实服务模块的实际产物，例如 `server/ruoyi-auth/target`、`server/ruoyi-gateway/target`、`server/ruoyi-modules/*/target` 或 `server/ruoyi-visual/ruoyi-monitor/target`。
- 前端缓存和构建路径是否指向 [web](../../web) 和当前真实的 `package-lock.json` 或实际采用的锁文件。
- 服务名、部署目录和 systemd 模板是否保持同一语境。
- `server-release.yml` 中的 `target_module` 是否与远端服务实际对应，不要把模块路径、Jar 文件名和 systemd 服务名混成一个概念。

## 发布前必须确认

1. 后端构建命令在 [server](../../server) 下可执行。
2. 前端构建命令在 [web](../../web) 下可执行。
3. SQL 脚本版本与目标环境数据库状态匹配。
4. 环境变量与密钥已按 [environment-variable-template.md](environment-variable-template.md) 准备。
5. 发布后验证地址可访问 `/actuator/health` 和 `/actuator/prometheus`。

## Harness 纠偏提醒

- 发布材料的目标是减少真实交付风险，不是扩张新的平台叙事。
- 发现脚本、workflow、制品名和真实代码路径不一致时，优先修路径和验证，不要继续复制旧说明。
- 如果发布事项涉及 SQL、API、响应码或观测材料，必须同步更新对应文档。
