---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 设计文档目录入口，汇总后台管理功能路线、认证权限设计与真实功能域说明。
---

# 设计文档总览

## 目标

本目录沉淀 HernessDemo 当前后台管理系统的功能设计入口。设计文档必须围绕 RuoYi-Vue-Plus 已有功能域展开，不能继续维护 ProjectPilot 搜索、计费或项目管理 MVP 这类无代码事实支撑的路线。

## 推荐入口

- 当前功能路线：[docs/design/backend-admin-roadmap.md](backend-admin-roadmap.md)
- 认证与权限：[docs/design/feature-auth.md](feature-auth.md)
- 真实代码地图：[docs/architecture/code-map.md](../architecture/code-map.md)
- 任务导航：[docs/README.md](../README.md)

## 文档索引

| 业务方向 | 文档 |
| --- | --- |
| 后台管理功能路线 | [docs/design/backend-admin-roadmap.md](backend-admin-roadmap.md) |
| 认证、会话、租户与权限 | [docs/design/feature-auth.md](feature-auth.md) |

## 维护规则

- 新增设计前先确认对应真实模块：`system`、`monitor`、`tool/gen`、`workflow`、`demo` 或 `common`。
- 新增功能方向时，在本目录增加对应设计文档，并同步更新本文档和 [docs/README.md](../README.md)。
- 设计涉及接口、响应码、SQL、菜单权限或发布影响时，同步更新相关参考文档。
- 已废弃的设计不要继续保留长篇说明，应删除或在索引中明确标记为历史背景。
