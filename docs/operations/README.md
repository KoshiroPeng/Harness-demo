---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 运维文档总览

## 目标

本目录沉淀 HernessDemo 的发布验证、回滚、主机初始化、配置密钥和运行手册，帮助协作者在高风险操作和运行问题排查时快速进入正确手册。

## 推荐入口

如果你现在是按任务查找文档，优先阅读：

- [docs/README.md](../README.md)

如果你现在是做发布、回滚、主机初始化或值班处理，优先阅读：

- [docs/delivery/delivery-operations-map.md](../delivery/delivery-operations-map.md)

## 文档索引

| 主题 | 文档 |
| --- | --- |
| 发布验证 | [docs/operations/release-verification.md](release-verification.md) |
| 回滚手册 | [docs/operations/rollback-runbook.md](rollback-runbook.md) |
| 远端主机初始化 | [docs/operations/remote-host-bootstrap.md](remote-host-bootstrap.md) |
| GitHub Environment 配置 | [docs/operations/github-environment-setup.md](github-environment-setup.md) |
| 配置与密钥治理 | [docs/operations/config-and-secrets.md](config-and-secrets.md) |
| 运行手册总览 | [docs/operations/runbooks.md](runbooks.md) |
| 服务目标与门禁 | [docs/operations/slo-and-gates.md](slo-and-gates.md) |

## 使用建议

- 做交付设计时，把本目录作为“运行约束”和“故障处置约束”的来源。
- 做测试设计时，若涉及发布后验证、回滚验证或外部依赖异常，应同步参考本目录。
- 做需求评审时，若存在非功能性要求，例如可观测性、运行告警、发布验证或回滚要求，应把要求落到本目录相关文档。

## 维护规则

- 新增运行手册、验证步骤或密钥治理规则后，必须同步更新本文档。
- 若新增内容会影响交付主路径，还必须同步更新 [docs/delivery/delivery-operations-map.md](../delivery/delivery-operations-map.md)。
