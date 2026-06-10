#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于在执行 docker compose build 之前，
# 先构建当前仓库真实需要的后端 Jar 和前端 dist，避免运行阶段才发现缺少制品。

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/../.." && pwd)"
skip_frontend_install="${SKIP_FRONTEND_INSTALL:-false}"

echo "开始构建后端 Maven 制品"
(
  cd "${repo_root}/server"
  mvn -B -DskipTests package
)

echo "开始构建前端静态资源"
(
  cd "${repo_root}/web"
  if [[ "${skip_frontend_install}" != "true" ]]; then
    npm install
  fi
  npm run build:prod
)

echo "构建完成：后端 Jar 与前端 dist 已就绪。"

