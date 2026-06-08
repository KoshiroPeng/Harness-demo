---
last_updated: 2026-06-08
status: active         # active | deprecated | draft
owner: "@PengKang"
---

# 参考文档总览

## 目标

本目录沉淀 HernessDemo 对外协议和共享参考资料，帮助开发、测试和评审快速找到接口契约和错误码基线。

## 文档索引

| 主题 | 文档 |
| --- | --- |
| API 规范 | [docs/reference/api-spec.yaml](api-spec.yaml) |
| 错误码 | [docs/reference/error-codes.md](error-codes.md) |

## 使用建议

- 开发接口前，先阅读 API 规范和错误码文档。
- 需求、设计、代码和测试评审若涉及接口协议，优先把本目录作为统一依据。
- 涉及错误响应、状态码或接口字段变化时，必须同步更新本目录。

## 维护规则

- API 变更必须同步更新 [docs/reference/api-spec.yaml](api-spec.yaml)。
- 错误码变更必须同步更新 [docs/reference/error-codes.md](error-codes.md)。
