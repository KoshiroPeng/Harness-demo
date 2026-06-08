---
last_updated: 2026-06-08
status: active
owner: "@PengKang"
description: HernessDemo 测试用例评审清单，用于检查需求覆盖、步骤清晰度与回归范围。
---

# 测试用例评审清单

## 评审重点

1. 每个需求都有对应的测试用例
2. 测试步骤清晰准确
3. 覆盖范围合理

## 适用范围

- 测试用例评审
- 缺陷回归用例评审
- 集成测试用例评审

## 清单

| 重要性 | 序号 | Checklist |
| --- | --- | --- |
| 必选 | 1 | 是否所有需求都有对应测试用例？ |
| 必选 | 2 | 是否每个缺陷都有对应测试用例？ |
| 必选 | 3 | 是否每个测试用例的操作步骤都有清晰描述？ |
| 必选 | 4 | 影响范围是否有对应测试用例？ |
| 必选 | 5 | 是否有集成测试阶段的用例，集成测试用例是否合理？ |
| 必选 | 6 | 用例是否考虑实际数据量和可能异常情况？ |
| 必选 | 7 | 用例是否考虑前置条件，是否依赖外部系统？ |
| 必选 | 8 | 是否规划核心功能回归用例？ |
| 必选 | 9 | 用例是否有关联需求？ |
| 可选 | 10 | 缺陷用例是否在描述中体现对应缺陷？ |
| 必选 | 11 | 用例是否优先覆盖当前后台管理主链路，而不是被历史过渡流程分散重点？ |

## 当前项目适配说明

- 测试策略与测试分层优先参考 [docs/conventions/testing.md](../conventions/testing.md)。
- 若测试范围讨论中引用 Harness Engineering，应同步参考 [docs/architecture/harness-engineering-adaptation.md](../architecture/harness-engineering-adaptation.md)，确认测试重点仍围绕真实代码和主链路收敛。
- 修复缺陷时，必须满足“先补回归测试，再修复实现”的项目规则。
- 若测试用例涉及发布、回滚、环境变量、外部系统依赖或上线验证，应同步参考 [deploy/release/README.md](../../deploy/release/README.md) 与 [deploy/release/release-checklist.md](../../deploy/release/release-checklist.md)。
