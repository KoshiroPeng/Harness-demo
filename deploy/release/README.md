---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 发布支撑目录入口，汇总发布、回滚、初始化、验证脚本和当前 workflow 历史残留风险。
---

# 发布脚本说明

本目录承载 HernessDemo 的发布编排辅助脚本，目标是把发布计划、发布后验证、远端部署和回滚检查沉淀为可执行资产。

## 当前状态

当前发布脚本本身位于 [deploy/release](.)，但 `.github/workflows` 中部分 workflow 仍引用历史 `services/callcenter-server` 路径。真实发布前必须先修正 workflow 和制品路径，不能直接把现有 GitHub Actions 当成可用发布链路。

真实后端源码入口是 [server](../../server)，后端 Jar 构建入口是 [server/ruoyi-admin](../../server/ruoyi-admin)。

## 当前文件说明

- [render-release-plan.sh](render-release-plan.sh)：根据环境、版本号和 `dry-run` 标记生成发布计划。
- [verify-release.sh](verify-release.sh)：对目标环境执行最小发布后验证，重点检查健康检查和指标端点。
- [deploy-via-ssh.sh](deploy-via-ssh.sh)：通过 SSH 与 SCP 执行最小远端发布骨架。
- [rollback-via-ssh.sh](rollback-via-ssh.sh)：通过 SSH 执行指定版本制品的远端回滚。
- [herness-demo.service.template](herness-demo.service.template)：历史命名下的 systemd 服务模板，供正式环境标准化托管时参考。
- [bootstrap-remote-host.sh](bootstrap-remote-host.sh)：首次初始化远端主机目录、环境文件与 systemd 服务。
- [release-checklist.md](release-checklist.md)：发布、验证与回滚前后的最小检查清单。
- [environment-variable-template.md](environment-variable-template.md)：环境变量和密钥准备模板。

## Workflow 风险

以下 workflow 需要先核对和修正后再使用：

- [.github/workflows/agent-guardrails.yml](../../.github/workflows/agent-guardrails.yml)
- [.github/workflows/server-release.yml](../../.github/workflows/server-release.yml)
- [.github/workflows/server-rollback.yml](../../.github/workflows/server-rollback.yml)
- [.github/workflows/bootstrap-remote-host.yml](../../.github/workflows/bootstrap-remote-host.yml)

重点检查：

- `working-directory` 是否指向 [server](../../server)。
- Maven cache path 是否指向 [server/pom.xml](../../server/pom.xml)。
- Jar 查找路径是否匹配 `server/ruoyi-admin/target` 的实际产物。
- 服务名、部署目录和 systemd 模板是否仍使用历史命名。

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
