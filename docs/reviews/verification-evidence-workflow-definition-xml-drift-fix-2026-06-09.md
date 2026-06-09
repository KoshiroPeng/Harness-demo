---
last_updated: 2026-06-09
status: active
owner: "@PengKang"
description: HarnessBase workflow definition XML 前后端接口漂移修复验证证据，记录历史残留删除、reference 同步和前端构建验证结果。
---

# 验证证据

## 基本信息

- 任务名称：workflow definition XML 前后端接口漂移修复
- 验证时间：2026-06-09
- 验证人：Codex
- 关联需求 / 缺陷 / 评审：前端 `definitionXml` 历史路径残留与后端 `FlwDefinitionController` 不一致
- 变更范围：[web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts)、[web/src/api/workflow/definition/types.ts](../../web/src/api/workflow/definition/types.ts)、[docs/reference/README.md](../reference/README.md)、[docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)、[docs/plans/backlog.md](../plans/backlog.md)

## 验证目标

- 本次需要证明什么：
  - 前端不再保留后端不存在的 `/workflow/definition/definitionXml/{definitionId}` 路径封装
  - 前端仍保留真实存在的 `/workflow/definition/xmlString/{id}` 封装
  - reference、backlog 和任务说明已同步移除这条已修复漂移
- 本次不覆盖什么：
  - workflow 模块页面联调
  - 后端流程定义导出内容正确性
  - 其他未识别的新接口漂移项

## 验证方式

| 序号 | 验证项 | 验证方式 | 结果 | 备注 |
| --- | --- | --- | --- | --- |
| 1 | 前端残留调用核对 | `rg -n "definitionXml|xmlString" web/src` | 通过 | `definitionXml` 仅在 API 文件残留，页面不存在实际调用点 |
| 2 | 前端 API 封装收敛 | 检查 [web/src/api/workflow/definition/index.ts](../../web/src/api/workflow/definition/index.ts) | 通过 | 已删除 `definitionXml`，保留 `xmlString(id)` |
| 3 | 孤立类型清理 | 检查 [web/src/api/workflow/definition/types.ts](../../web/src/api/workflow/definition/types.ts) | 通过 | 已删除仅供 `definitionXml` 使用的 `definitionXmlVO` |
| 4 | 后端事实核对 | 检查 [FlwDefinitionController.java](../../server/ruoyi-modules/ruoyi-workflow/src/main/java/org/dromara/workflow/controller/FlwDefinitionController.java) | 通过 | 后端当前仍只暴露 `GET /workflow/definition/xmlString/{id}` |
| 5 | API 摘要与文档同步 | 检查 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)、[docs/reference/README.md](../reference/README.md)、[docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md)、[docs/plans/backlog.md](../plans/backlog.md) | 通过 | `api-spec` 未写入历史假路径，reference 与 backlog 已移除待修记录 |
| 6 | 前端构建验证 | `cd web && pnpm build:prod` | 通过 | 生产构建成功，存在大体积 chunk 警告，但不影响本次接口漂移修复 |

## 基线对齐结果

- 是否符合当前技术基线和代码地图：符合，前端 API 客户端与真实后端 Controller 保持一致。
- 是否仍存在本批次待修接口漂移：本批次已识别的 `monitor cache` 与 `workflow definition XML` 两条接口漂移均已收敛。
- 若后续再发现差异，是否有记录入口：有，按 [docs/reference/README.md](../reference/README.md) 和 [docs/plans/frontend-backend-api-drift-fix-brief.md](../plans/frontend-backend-api-drift-fix-brief.md) 继续登记。

## 关键命令或操作记录

```text
rg -n "definitionXml|xmlString" web/src
cd web
pnpm build:prod
```

## 结果摘要

- 功能结果：workflow definition 前端 API 已收敛到真实存在的 `xmlString` 路径。
- 测试结果：调用核对通过，前端生产构建通过。
- 文档同步结果：reference、任务说明与 backlog 已同步更新，不再把该问题保留为待修差异。
- 发布或运行验证结果：未执行，本次变更未涉及发布脚本和后端运行参数。

## 未覆盖风险

- 本次前端构建仍有大体积 chunk 警告，属于现存前端打包体积问题，不是本次接口漂移修复引入的新回归。
- 本次未进行 workflow 页面联调，如后续发现页面对返回结构有隐式依赖，应在功能任务中补前端页面验证。

## 后续动作

- 将本批次“接口漂移收敛”结论作为范例，后续继续按“先核对事实、再删除残留、最后补验证证据”的 Harness 闭环执行。
- 继续转向 backlog 中更高优先级的真实代码质量问题，例如 `System.out.println`、字段级 `@Autowired`、缺失测试等。
