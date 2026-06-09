---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase 前后端接口差异修复任务说明，记录 workflow definition XML 与 monitor cache 两类接口漂移的收敛结论和验证要求。
---

# 前后端接口差异修复任务说明

## 目标

本文档把当前已知的前后端接口差异收敛成后续代码任务说明。它不是本轮文档治理的延续，而是给下一轮允许修改代码时使用的执行入口。

当前批次已识别的接口漂移项已全部完成收敛：

1. workflow definition XML 路径差异。
2. monitor cache 前端残留接口。

## 当前边界

- 本文档只定义任务、证据、推荐处理路径和验收标准。
- 本文档不修改 [web](../../web) 或 [server](../../server) 代码。
- 代码修复前仍需重新执行一次 `git status` 和源码核对，防止分支已经变化。

## 已收敛差异一：workflow definition XML 路径

### 当前事实

| 位置 | 当前事实 |
| --- | --- |
| [web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) | 已删除 `definitionXml(definitionId)` 残留，仅保留真实存在的 `xmlString(id)` |
| [FlwDefinitionController.java](../../server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java) | 后端存在 `/workflow/definition/xmlString/{id}`，且当前仍没有 `/workflow/definition/definitionXml/{definitionId}` |
| [docs/reference/README.md](../reference/README.md) | 已移除该差异记录，reference 当前不再保留这条历史路径漂移 |

前端证据：

```text
web/src/api/workflow/definition/index.ts:103-107 xmlString -> /workflow/definition/xmlString/${id}
```

后端证据：

```text
server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java:188-191 @GetMapping("/xmlString/{id}")
```

### 处理结论

本次采用“删除前端历史残留，不新增后端兼容接口”的收敛方式。

处理依据：

- 后端已经存在真实可用的 `xmlString/{id}`。
- 前端同一文件已经存在 `xmlString(id)` 封装。
- `definitionXml` 与 `definitionXmlVO` 仅在 API 文件内部自引用，没有页面调用点。
- 新增后端兼容接口会扩大 API 面，且容易让历史路径继续存活。

调用核对命令：

```bash
rg -n "definitionXml" web/src
```

处理结果：

- 已删除 `definitionXml` 封装。
- 已删除未再使用的 `definitionXmlVO` 类型。
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 无需改动，因为原本只保留真实存在的 `/workflow/definition/xmlString/{id}`。

### 验收标准

- [x] [web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) 不再请求 `/workflow/definition/definitionXml/{definitionId}`。
- [x] 前端仍能通过 `/workflow/definition/xmlString/{id}` 获取流程定义 JSON/XML 字符串。
- [x] [docs/reference/README.md](../reference/README.md) 的该差异记录已删除。
- [x] [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 未新增 `definitionXml` 路径。
- [x] 前端类型检查或相关构建命令通过；已执行 `pnpm build:prod`，构建成功，存在大体积 chunk 警告但不影响本次漂移修复。

## 已收敛差异二：monitor cache 前端残留

### 当前事实

| 位置 | 当前事实 |
| --- | --- |
| [web/src/api/monitor/cache/index.ts](../../web/src/api/monitor/cache/index.ts) | 已删除 `getNames`、`getKeys`、`getValue`、`clearCacheName`、`clearCacheKey`、`clearCacheAll` 前端残留，只保留 `/monitor/cache` |
| [CacheController.java](../../server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java) | 当前只暴露 `GET /monitor/cache` |
| [docs/reference/README.md](../reference/README.md) | 已移除该差异记录，reference 当前仅保留仍未修复的漂移项 |

修复前证据：

```text
web/src/api/monitor/cache/index.ts:6-10 getCache -> /monitor/cache
web/src/api/monitor/cache/index.ts:14-58 listCacheName/listCacheKey/getCacheValue/clearCacheName/clearCacheKey/clearCacheAll -> /monitor/cache/*
```

后端证据：

```text
server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java:23 @RequestMapping("/monitor/cache")
server/ruoyi-modules/ruoyi-system/src/main/java/org/dromara/system/controller/monitor/CacheController.java:31-33 @GetMapping()
```

处理结论：

- 页面实际只调用 `getCache()`，未调用缓存细分接口。
- 因此前端已删除未使用的缓存细分接口封装，不新增后端缓存管理接口。
- 当前 monitor cache 功能定位仍然保持为缓存概览监控，而不是缓存管理。

对应调用核对命令：

```bash
rg -n "listCacheName|listCacheKey|getCacheValue|clearCacheName|clearCacheKey|clearCacheAll" web/src
```

保留结论：

- 在没有明确产品需求前，不新增后端缓存清理接口。
- 如果后续确实需要缓存名称、键值或清理能力，应作为独立后端功能任务处理，并同步权限、审计、测试和风险说明。

### 验收标准

- [x] 前端不再请求后端不存在的 `/monitor/cache/getNames`、`/getKeys`、`/getValue`、`/clearCacheName`、`/clearCacheKey`、`/clearCacheAll`，且后端未新增这些接口。
- [ ] 如果新增后端缓存清理接口，必须有权限校验、操作日志和风险说明。
- [x] [docs/reference/README.md](../reference/README.md) 的缓存差异记录已删除。
- [ ] [docs/reference/api-spec.yaml](../reference/api-spec.yaml) 只列真实存在且已核对的接口。
- [x] 前端构建或对应聚焦验证通过；已执行 `pnpm build:prod`，构建成功，存在大体积 chunk 警告但不影响本次漂移修复。

## 推荐执行顺序

1. 发现前后端接口不一致时，先搜索真实调用点和后端 Controller。
2. 若后端已有真实替代入口，优先删除前端残留或替换调用，不扩张兼容接口。
3. 每修完一类差异，同步更新 [docs/reference/README.md](../reference/README.md)。
4. 如果实际接口发生变化，同步检查 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
5. 如果涉及权限、菜单或 SQL，同步检查 [server/script/sql](../../server/script/sql) 和 [docs/reference/sql-change-checklist.md](../reference/sql-change-checklist.md)。

## 验证建议

代码任务完成后至少执行：

```bash
git diff --check
```

前端只改 API 封装时，建议执行：

```bash
cd web
pnpm lint
pnpm build:prod
```

后端如果新增或调整 Controller，建议执行：

```bash
cd server
mvn -B test
```

若本机依赖不完整或命令不可执行，必须在验证证据中写明原因，并记录替代验证方式。

## 文档同步清单

代码修复完成后同步检查：

- [docs/reference/README.md](../reference/README.md)
- [docs/reference/api-spec.yaml](../reference/api-spec.yaml)
- [docs/design/feature-admin-domains.md](../design/feature-admin-domains.md)
- [docs/plans/backlog.md](backlog.md)
- [docs/reviews/verification-evidence-doc-governance-2026-06-08.md](../reviews/verification-evidence-doc-governance-2026-06-08.md) 或新的验证证据文档
