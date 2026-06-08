---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 命名规范，统一 RuoYi-Vue-Plus 模块、Java、前端、SQL、API 与文档命名方式。
---

# 命名规范

## 通用原则

- 优先沿用当前 RuoYi-Vue-Plus 代码命名，不为局部改动创造第二套术语。
- 同一概念在 Java、SQL、API、前端和文档中使用同一语义。
- 英文命名保持简洁清晰，避免无意义缩写。
- 历史技术标识可以保留在既有路径和制品中，但新增文档必须说明语境。

## Java 包与模块

当前根包是 `org.dromara`。新增代码优先放入现有包结构：

```text
org.dromara.web
org.dromara.common.*
org.dromara.system.*
org.dromara.generator.*
org.dromara.workflow.*
org.dromara.demo.*
```

新增公共能力优先进入对应 `ruoyi-common-*`；新增业务能力优先进入对应 `ruoyi-modules/*`。

## Java 类名

| 类型 | 当前风格示例 |
| --- | --- |
| Controller | `SysUserController`、`FlwDefinitionController` |
| Service 接口 | `ISysUserService`、`ISysClientService` |
| Service 实现 | `SysUserServiceImpl` |
| Mapper | `SysUserMapper` |
| 业务对象 | `SysUserBo` |
| 视图对象 | `SysUserVo` |
| 实体 | `SysUser` |
| 配置类 | `RedisConfig`、`I18nConfig` |

不要在同一功能域里混入 `ProjectController`、`TaskService` 这类旧 ProjectPilot 语义。

## 方法名

- 查询单个对象：`queryById`、`selectById`、`getInfo`
- 查询列表：`queryList`、`list`、`selectList`
- 分页查询：`queryPageList`
- 新增：`insertByBo`、`add`
- 更新：`updateByBo`、`edit`
- 删除：`deleteWithValidByIds`、`remove`
- 校验唯一性：`checkXxxUnique`

优先沿用所在模块已有命名，不为同类 CRUD 创造新动词。

## 数据库命名

- 当前系统表多使用 `sys_` 前缀，例如 `sys_user`、`sys_role`。
- 工作流表和示例表沿用对应模块已有前缀。
- SQL 脚本位于 [server/script/sql](../../server/script/sql)。
- 结构变更必须同步初始化 SQL 与 `update/` 升级脚本。

当前没有 Flyway migration，命名规范不要假定存在 `Vxxx__xxx.sql`。

## API 命名

当前接口路径沿用 RuoYi-Vue-Plus 风格：

```text
/auth/login
/auth/logout
/system/user/list
/system/menu/getRouters
/tool/gen/list
/workflow/definition/list
```

新增接口优先沿用现有模块路径和权限标识，不要改成 `/api/v1/projects` 这类不存在的产品路线。

## 前端命名

- API 封装按功能域放在 [web/src/api](../../web/src/api)。
- 页面按功能域放在 [web/src/views](../../web/src/views)。
- Vue 组件使用 PascalCase。
- 组合式函数使用 `use` 前缀。
- Pinia store 使用现有 `modules` 风格。

## 文档命名

- 文档文件名使用小写英文和连字符。
- 目录入口统一使用 `README.md`。
- 文档标题使用中文，代码标识保持英文。
- 新增内部 Markdown 必须带元数据标头。
