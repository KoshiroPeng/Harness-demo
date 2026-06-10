---
last_updated: 2026-06-10
status: active
owner: "@PengKang"
description: HarnessBase 环境变量模板，统一维护部署、运行、发布验证和远端 SSH 所需变量与密钥。
---

# 环境变量与密钥模板

本文档沉淀 HarnessBase 各环境的变量和密钥清单，便于在 GitHub Environments、部署平台或密钥管理系统中统一维护。

## 公共变量

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `APP_PROFILE` | variable | 否 | `prod` | Spring profile 名称 |
| `VERIFY_BASE_URL` | variable | 否 | `https://staging.example.com` | 发布后验证访问地址 |
| `OBSERVATION_MINUTES` | variable | 否 | `15` | 发布后观察窗口分钟数 |
| `RELEASE_OWNER` | variable | 否 | `backend-team` | 发布负责人 |
| `ONCALL_CONTACT` | variable | 否 | `oncall@example.com` | 值班联系人 |
| `APP_DEPLOY_DIR` | variable | 否 | `/opt/harness-base` | 远端部署目录；单服务 SSH 发布默认可用该值，compose 部署建议改为独立目录，例如 `/opt/harness-base-compose` |
| `APP_DEPLOY_PORT` | variable | 否 | `22` | SSH 端口 |
| `APP_DEPLOY_STRATEGY` | variable | 否 | `systemd` | 远端启动策略，支持 `systemd` 或 `nohup` |
| `APP_SERVICE_NAME` | variable | 否 | `harness-base` | systemd 服务名，真实发布前可统一为目标服务名 |

## docker-compose 部署变量

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `COMPOSE_FILE_UPLOAD_PATH` | variable | 否 | `/data/harness-base/uploadPath` | 文件服务上传目录映射 |

## 后端部署变量

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `SERVER_PORT` | variable | 否 | `8080` | 服务端口 |
| `JAVA_OPTS` | variable | 否 | `-Xms512m -Xmx1024m` | JVM 运行参数 |
| `LOG_LEVEL_ROOT` | variable | 否 | `INFO` | 根日志级别 |
| `JDK_VERSION` | variable | 否 | `17` | 目标运行时 JDK 主版本 |

## 后端密钥

| 名称 | 类型 | 是否敏感 | 示例 | 说明 |
| --- | --- | --- | --- | --- |
| `DB_URL` | secret | 是 | `jdbc:mysql://...` | 数据库连接串 |
| `DB_USERNAME` | secret | 是 | `app_user` | 数据库账号 |
| `DB_PASSWORD` | secret | 是 | `***` | 数据库密码 |
| `JWT_SIGNING_KEY` | secret | 是 | `***` | JWT 签名密钥 |
| `APP_DEPLOY_HOST` | secret | 是 | `server.example.com` | 远端部署主机 |
| `APP_DEPLOY_USER` | secret | 是 | `deploy` | 远端部署账号 |
| `APP_DEPLOY_KEY` | secret | 是 | `***` | SSH 私钥内容 |

## docker-compose 使用提醒

- compose workflow 仍复用 `APP_DEPLOY_HOST`、`APP_DEPLOY_USER`、`APP_DEPLOY_KEY`、`APP_DEPLOY_DIR` 和 `APP_DEPLOY_PORT` 作为远端连接参数，但推荐把 `APP_DEPLOY_DIR` 设为独立 compose 目录，例如 `/opt/harness-base-compose`，避免与单服务 SSH 发布目录混用。
- 若使用 [deploy/compose/.env.prod.example](../compose/.env.prod.example)，应在真实环境中把对应值落到 `deploy/compose/.env`，不要直接使用模板默认值。
- `PUBLIC_BASE_URL`、`FILE_SERVICE_PUBLIC_URL`、`RUOYI_PROFILE` 等 compose 运行时参数定义在 [deploy/compose/.env](../compose/.env) 中，不通过 GitHub Environment variable 直接注入 workflow。
- 若生产环境使用 `RUOYI_PROFILE=prod`，必须确认 Nacos 中 `application-prod.yml` 和各服务 `*-prod.yml` 已经存在；当前 compose 初始化 SQL 会基于 `dev` 配置自动复制一份 `prod` 骨架，但正式值仍应人工校准。
- 若使用 compose 回滚，当前依赖远端 `APP_DEPLOY_DIR/backups/` 中的快照目录；正式环境应把该目录纳入主机级备份策略。
- 若使用 compose 数据备份与恢复，当前依赖 `COMPOSE_FILE_UPLOAD_PATH` 指向真实上传目录宿主机路径；workflow 会把该值传给脚本内部变量 `FILE_UPLOAD_PATH_OVERRIDE`，否则文件服务数据归档无法覆盖完整范围。

## 维护规则

- 新增配置项时，同步补充到本模板。
- 删除配置项时，同步清理对应环境中的遗留变量和密钥。
- 真实发布前必须确认变量名称与 workflow、脚本、systemd 模板一致。
- 不要把密钥写入仓库、文档示例或提交信息。

## 配套脚本

- 主机初始化：[deploy/release/bootstrap-remote-host.sh](bootstrap-remote-host.sh)
- 远端部署：[deploy/release/deploy-via-ssh.sh](deploy-via-ssh.sh)
- compose 远端部署：[deploy/compose/deploy-compose-via-ssh.sh](../compose/deploy-compose-via-ssh.sh)
- compose 快照：[deploy/compose/backup-compose-release.sh](../compose/backup-compose-release.sh)
- compose 回滚：[deploy/compose/rollback-compose-via-ssh.sh](../compose/rollback-compose-via-ssh.sh)
- compose 数据备份：[deploy/compose/backup-compose-data.sh](../compose/backup-compose-data.sh)
- compose 数据恢复：[deploy/compose/restore-compose-data.sh](../compose/restore-compose-data.sh)
- 发布后验证：[deploy/release/verify-release.sh](verify-release.sh)
- 发布前后检查：[deploy/release/release-checklist.md](release-checklist.md)
