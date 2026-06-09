---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: ProjectPilot 登录注册链路跨模块用户 Mapper 依赖收口的验证证据，记录 ruoyi-admin 回切 ruoyi-system service 的事实与验证结果。
---

# 验证证据

## 基本信息

- 任务名称：登录注册链路跨模块用户 Mapper 依赖收口
- 验证时间：2026-06-09
- 验证人：Codex
- 关联范围：[SysLoginService.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/SysLoginService.java)、[SysRegisterService.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/SysRegisterService.java)、[PasswordAuthStrategy.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/impl/PasswordAuthStrategy.java)、[EmailAuthStrategy.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/impl/EmailAuthStrategy.java)、[SmsAuthStrategy.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/impl/SmsAuthStrategy.java)、[SocialAuthStrategy.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/impl/SocialAuthStrategy.java)、[ISysUserService.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service/ISysUserService.java)、[SysUserServiceImpl.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service/impl/SysUserServiceImpl.java)

## 验证目标

- `ruoyi-admin` 登录、注册、密码登录、邮箱登录、短信登录、社交登录链路不再直接依赖 `SysUserMapper`
- 用户查询与登录信息记录能力统一回收到 `ruoyi-system` 的 `ISysUserService`
- 本次改动没有引入新的补丁格式问题

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | `ruoyi-admin` 是否还残留 `SysUserMapper` 直连 | `rg -n "SysUserMapper|userMapper" server/ruoyi-admin/src/main/java` | 通过 | 扫描结果为空，`rg` 以退出码 1 返回，表示未命中残留 |
| 2 | 用户查询能力是否统一经由 service | 检查上述 6 个登录/注册相关类的差异 | 通过 | 用户名、邮箱、手机号、用户 ID 查询已分别切换到 `ISysUserService` |
| 3 | 登录信息写入是否统一经由 service | 检查 [SysLoginService.java](../../server/ruoyi-admin/src/main/java/org/dromara/web/service/SysLoginService.java) 与 [SysUserServiceImpl.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service/impl/SysUserServiceImpl.java) | 通过 | `SysLoginService.recordLoginInfo` 已改为调用 `userService.recordLoginInfo` |
| 4 | 差异格式检查 | `git diff --check` | 通过 | 仅出现 Git 的 LF/CRLF 警告，没有空白符或补丁格式错误 |
| 5 | 聚焦编译验证 | `cd server && mvn -B -pl ruoyi-admin,ruoyi-modules/ruoyi-system -am -DskipTests compile` | 受阻 | 编译在 `ruoyi-common-oss` 的 AWS SDK 缺失问题处失败，不是本次改动引入 |

## 关键命令记录

```text
rg -n "SysUserMapper|userMapper" server/ruoyi-admin/src/main/java
git diff -- server/ruoyi-admin/src/main/java/org/dromara/web/service server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/service
git diff --check
cd server
mvn -B -pl ruoyi-admin,ruoyi-modules/ruoyi-system -am -DskipTests compile
```

## 结果摘要

- 本次已完成 `ruoyi-admin -> ruoyi-system` 的一轮真实边界收口，登录注册主链路不再直接跨模块依赖 `SysUserMapper`
- `ruoyi-system` 新增了两项最小必要能力：`selectUserByEmail` 和 `recordLoginInfo`
- 编译验证仍被仓库已有的 `ruoyi-common-oss` AWS SDK 依赖缺失阻塞，后续需要单独处理该基础设施问题，才能恢复更完整的模块编译回归

## 未覆盖风险

- 本次只处理了 `SysUserMapper` 这一组真实违规点，`ruoyi-admin` 中其他 service 是否仍存在跨模块直连其他 mapper，还需要继续扫描
- 由于 `ruoyi-common-oss` 构建阻塞仍在，暂时无法用一次完整的聚焦编译证明登录注册链路的所有传递依赖都可通过编译

## 后续动作

- 继续扫描 `ruoyi-admin` 中其他跨模块 mapper 直连路径，优先处理登录、权限、租户等主链路
- 单独建立 `ruoyi-common-oss` 依赖阻塞的修复任务，恢复 `ruoyi-admin` 与 `ruoyi-system` 的编译闭环
