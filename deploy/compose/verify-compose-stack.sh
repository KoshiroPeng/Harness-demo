#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于对 docker-compose 部署结果执行最小验证，
# 重点确认容器进程、前端入口和网关健康检查是否可访问。

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
env_file="${script_dir}/.env"

if [[ -f "${env_file}" ]]; then
  # shellcheck disable=SC1090
  source "${env_file}"
else
  # shellcheck disable=SC1091
  source "${script_dir}/.env.example"
fi

compose_file="${script_dir}/docker-compose.yml"

echo "检查容器状态"
docker compose --env-file "${env_file:-${script_dir}/.env.example}" -f "${compose_file}" ps

gateway_port="${GATEWAY_HTTP_PORT:-8080}"
nginx_port="${NGINX_HTTP_PORT:-80}"
monitor_port="${MONITOR_HTTP_PORT:-9100}"

echo "检查前端入口：http://127.0.0.1:${nginx_port}"
curl --fail --silent --show-error "http://127.0.0.1:${nginx_port}" >/dev/null

echo "检查网关健康端点：http://127.0.0.1:${gateway_port}/actuator/health"
curl --fail --silent --show-error "http://127.0.0.1:${gateway_port}/actuator/health"

echo "检查监控服务健康端点：http://127.0.0.1:${monitor_port}/actuator/health"
curl --fail --silent --show-error "http://127.0.0.1:${monitor_port}/actuator/health"

echo "docker-compose 最小验证通过。"

