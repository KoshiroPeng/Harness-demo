#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于把 compose 部署包同步到远端主机，
# 并在远端执行镜像构建、容器拉起和最小验证。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base-compose}"
dry_run="${DRY_RUN:-true}"
env_file_path="${COMPOSE_ENV_FILE_PATH:-deploy/compose/.env}"
compose_file_path="${COMPOSE_FILE_PATH:-deploy/compose/docker-compose.yml}"
release_version="${RELEASE_VERSION:-unknown}"
backup_before_deploy="${BACKUP_BEFORE_DEPLOY:-true}"
if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" ]]; then
  echo "缺少 compose 远端部署所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY。" >&2
  exit 1
fi

if [[ ! -f "${env_file_path}" ]]; then
  echo "未找到 compose 环境文件：${env_file_path}" >&2
  exit 1
fi

if [[ ! -f "${compose_file_path}" ]]; then
  echo "未找到 compose 编排文件：${compose_file_path}" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出 compose 远端部署计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- compose 文件：${compose_file_path}"
  echo "- 环境文件：${env_file_path}"
  echo "- 发布版本：${release_version}"
  echo "- 部署前创建快照：${backup_before_deploy}"
  exit 0
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "创建远端目录：${target_dir}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" \
  "mkdir -p '${target_dir}'"

echo "同步 compose 部署包到远端"
tar -czf - \
  deploy/compose \
  deploy/observability \
  server/sql \
  server/docker/redis/conf \
  server/ruoyi-auth/target \
  server/ruoyi-gateway/target \
  server/ruoyi-modules/ruoyi-system/target \
  server/ruoyi-modules/ruoyi-gen/target \
  server/ruoyi-modules/ruoyi-job/target \
  server/ruoyi-modules/ruoyi-file/target \
  server/ruoyi-visual/ruoyi-monitor/target \
  web/dist | ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" \
  "tar -xzf - -C '${target_dir}'"

echo "同步 compose 环境文件"
scp -i "${key_file}" -P "${target_port}" -o StrictHostKeyChecking=no "${env_file_path}" \
  "${target_user}@${target_host}:${target_dir}/deploy/compose/.env"

if [[ "${backup_before_deploy}" == "true" ]]; then
  echo "部署前创建 compose 快照"
  APP_DEPLOY_HOST="${target_host}" \
  APP_DEPLOY_USER="${target_user}" \
  APP_DEPLOY_KEY="${target_key}" \
  APP_DEPLOY_PORT="${target_port}" \
  APP_DEPLOY_DIR="${target_dir}" \
  RELEASE_VERSION="${release_version}" \
  DRY_RUN="false" \
  bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/backup-compose-release.sh"
fi

echo "远端执行 compose 构建与部署"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"
bash deploy/compose/manage-compose.sh build-images
bash deploy/compose/manage-compose.sh up-all
bash deploy/compose/manage-compose.sh verify
echo "compose 部署完成：${release_version}"
EOF
