#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本统一封装 docker compose 常用操作，
# 让部署人员不需要记忆长命令，也能明确区分基础设施、业务服务和验证动作。

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
compose_file="${script_dir}/docker-compose.yml"
default_env_file="${script_dir}/.env"
fallback_env_file="${script_dir}/.env.example"

if [[ -f "${default_env_file}" ]]; then
  env_file="${default_env_file}"
else
  env_file="${fallback_env_file}"
fi

compose_cmd=(docker compose --env-file "${env_file}" -f "${compose_file}")

usage() {
  cat <<'EOF'
用法：
  bash deploy/compose/manage-compose.sh build-images
  bash deploy/compose/manage-compose.sh up-base
  bash deploy/compose/manage-compose.sh up-apps
  bash deploy/compose/manage-compose.sh up-all
  bash deploy/compose/manage-compose.sh down
  bash deploy/compose/manage-compose.sh restart
  bash deploy/compose/manage-compose.sh ps
  bash deploy/compose/manage-compose.sh logs [service]
  bash deploy/compose/manage-compose.sh verify
EOF
}

up_base() {
  "${compose_cmd[@]}" up -d ruoyi-mysql ruoyi-redis ruoyi-nacos
}

up_apps() {
  "${compose_cmd[@]}" up -d \
    ruoyi-auth \
    ruoyi-system \
    ruoyi-gen \
    ruoyi-job \
    ruoyi-file \
    ruoyi-monitor \
    ruoyi-gateway \
    ruoyi-nginx
}

case "${1:-}" in
  build-images)
    "${compose_cmd[@]}" build
    ;;
  up-base)
    up_base
    ;;
  up-apps)
    up_apps
    ;;
  up-all)
    up_base
    up_apps
    ;;
  down)
    "${compose_cmd[@]}" down
    ;;
  restart)
    "${compose_cmd[@]}" restart
    ;;
  ps)
    "${compose_cmd[@]}" ps
    ;;
  logs)
    if [[ $# -ge 2 ]]; then
      "${compose_cmd[@]}" logs -f "$2"
    else
      "${compose_cmd[@]}" logs -f
    fi
    ;;
  verify)
    bash "${script_dir}/verify-compose-stack.sh"
    ;;
  *)
    usage
    exit 1
    ;;
esac

