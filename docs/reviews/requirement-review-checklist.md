---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 需求评审清单，用于检查业务场景、流程、交互、现有模块关系与外部依赖说明。
---

# 需求评审清单

## 评审重点

1. 业务场景
2. 业务流程
3. 界面交互

## 适用范围

- 新功能需求评审
- 现有功能改造需求评审
- 跨模块联动需求评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 是否按模板要求编写需求规格说明书？ |
| 必选 | 2 | 是否有说明功能用户范围和已有角色的关系？ |
| 必选 | 3 | 是否在功能描述中说明功能的使用场景？ |
| 必选 | 4 | 是否在业务规则中对业务流程有清晰说明？ |
| 必选 | 5 | 是否和原有功能有关联，关联关系是否有清晰描述？ |
| 必选 | 6 | 关键界面是否有原型或设计图及配套说明？ |
| 必选 | 7 | 是否涉及外部数据或外部系统，外部数据或接口是否有明确业务规则？ |
| 必选 | 8 | 是否包含非功能性要求，例如性能、安全、审计、可观测性或发布要求？ |
| 必选 | 9 | 是否符合当前后台管理系统主线，是否避免把无代码事实支撑的平台化事项混入需求？ |

## 当前项目适配说明

- 认证、权限、租户和客户端授权相关需求应同步参考 [docs/design/feature-auth.md](../design/feature-auth.md)。
- 若需求讨论中引用 Harness Engineering，应同步参考 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)，确认它是工程方法而不是需求范围本身。
- 涉及 API 变更时，后续必须同步更新 [docs/reference/api-spec.yaml](../reference/api-spec.yaml)。
- 涉及错误码时，后续必须同步更新 [docs/reference/error-codes.md](../reference/error-codes.md)。
- 涉及发布、环境变量、回滚、上线验证或运行约束的非功能性需求，应补充到 [deploy/release/README.md](../../deploy/release/README.md) 或相关发布文档。
