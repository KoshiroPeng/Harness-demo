---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 本地可观测性目录入口，汇总指标、日志与观测支撑材料。
---

# 本地可观测性

本目录提供轻量级本地可观测性堆栈。

这些材料的定位是开发、重构和发布支撑层，用于帮助定位问题、验证系统状态，不应替代当前后台管理系统主线建设。

## 快速导航

- [docs/README.md](../../docs/README.md)：统一任务导航入口
- [docs/conventions/logging.md](../../docs/conventions/logging.md)：日志输出规范
- [docs/conventions/testing.md](../../docs/conventions/testing.md)：测试与验证基线
- [deploy/release/README.md](../release/README.md)：发布脚本与发布验证入口
- [deploy/compose/README.md](../compose/README.md)：整套微服务 docker-compose 部署入口
- [.github/README.md](../../.github/README.md)：CI、发布、回滚 workflow 入口

- Prometheus: `http://localhost:9090`
- Grafana: `http://localhost:3001`
- Loki: `http://localhost:3100`

启动可观测性组件：

```bash
docker compose -f deploy/observability/docker-compose.yml up -d
```

Grafana 默认账号密码均为 `admin`。Prometheus 会抓取 `http://host.docker.internal:8080/actuator/prometheus`，Promtail 会采集 `server/logs/*.log` 并发送到 Loki。

## 使用场景

- 本地联调或 docker-compose 整套部署后，确认应用是否已暴露 `/actuator/prometheus` 和日志输出。
- 修复监控、日志、性能或错误定位问题时，配合 [docs/architecture/data-flow.md](../../docs/architecture/data-flow.md) 使用。
- 发布前后做最小验证时，配合 [deploy/release/release-checklist.md](../release/release-checklist.md) 使用。

## 配套入口

- [docs/README.md](../../docs/README.md)：按任务场景查看还需要联读哪些文档。
- [docs/architecture/target-technology-baseline.md](../../docs/architecture/target-technology-baseline.md)：查看目标运行时基线。
- [deploy/release/release-checklist.md](../release/release-checklist.md)：如果本次观测用于发布验证，和发布检查清单一起使用。
- [deploy/compose/README.md](../compose/README.md)：如果本次观测用于 compose 部署后的整体验证，和 compose 部署入口一起使用。
- [docs/conventions/logging.md](../../docs/conventions/logging.md)：查看日志输出规范。
- [docs/conventions/testing.md](../../docs/conventions/testing.md)：查看测试与验证基线。

## 纠偏提醒

- 若当前没有真实主链路需要观测，优先保持最小可用，不要超前扩张观测体系。
- 若讨论中引用 Harness Engineering，应理解为“补齐定位与验证能力”，而不是单独建设观测平台。
