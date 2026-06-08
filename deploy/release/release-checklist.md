---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 发布检查清单，用于统一发布前、发布中、发布后和回滚前后的最小验证步骤。
---

# 发布检查清单

本清单用于服务当前 HernessDemo 后台管理系统交付，不用于把发布流程扩张成新的平台主线。

配套文档：

- [deploy/release/README.md](README.md)
- [deploy/release/environment-variable-template.md](environment-variable-template.md)
- [deploy/observability/README.md](../observability/README.md)
- [docs/architecture/code-map.md](../../docs/architecture/code-map.md)

## 发布前

- [ ] 目标版本已通过真实源码路径下的构建校验。
- [ ] `.github/workflows` 没有继续把 `services/callcenter-server` 当作源码入口。
- [ ] 变更范围、风险点和回滚路径已确认。
- [ ] SQL 初始化脚本和 `update/` 升级脚本已检查兼容性。
- [ ] 目标环境使用 JDK 17。
- [ ] 目标环境变量和密钥已准备完成。
- [ ] 发布制品路径与 [server/ruoyi-admin](../../server/ruoyi-admin) 实际构建产物一致。
- [ ] 观察窗口负责人和值班联系人已确认。
- [ ] 若为 `prod`，审批人已知晓发布时间和影响范围。

## 发布中

- [ ] 使用受控制品，不重新本地打包。
- [ ] 记录本次发布版本号和 Git SHA。
- [ ] 记录部署开始时间和执行人。
- [ ] 若步骤失败，立即停止后续扩散动作。

## 发布后

- [ ] 检查 `/actuator/health`。
- [ ] 检查 `/actuator/prometheus`。
- [ ] 检查启动日志、配置日志和 SQL 执行日志。
- [ ] 执行登录、用户信息或其他最小业务探针。
- [ ] 若本次包含前端交付，检查关键页面主链路和核心接口调用。
- [ ] 在观察窗口内确认无持续告警。

## 需要回滚时

- [ ] 确认目标回滚版本。
- [ ] 确认数据库结构兼容性。
- [ ] 执行回滚后再次验证健康检查和业务探针。
- [ ] 记录回滚原因、时间和恢复结果。

## 使用提醒

- 如果本次发布涉及 SQL、响应码、接口协议或环境变量变更，发布前应确认对应文档已经同步更新。
- 如果 workflow 或脚本仍保留历史命名，应在发布记录中明确残留范围和修正计划。
- 如果只是小步迭代，不要顺势扩张新的平台流程或额外审批链。
