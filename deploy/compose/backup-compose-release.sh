#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于在 compose 真实部署前，为远端当前部署目录创建一次可回滚快照。
# 快照内容聚焦当前 compose 配置、环境文件和发布元数据，不直接打包数据库或上传目录数据。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base-compose}"
release_version="${RELEASE_VERSION:-unknown}"
dry_run="${DRY_RUN:-true}"
backup_label="${BACKUP_LABEL:-$(date -u +%Y%m%dT%H%M%SZ)-${release_version}}"

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" ]]; then
  echo "缺少 compose 备份所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出 compose 备份计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 备份标签：${backup_label}"
  echo "- 发布版本：${release_version}"
  exit 0
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "远端创建 compose 回滚快照：${backup_label}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"
mkdir -p backups

backup_dir="backups/${backup_label}"
mkdir -p "\${backup_dir}"

if [[ -f deploy/compose/.env ]]; then
  cp deploy/compose/.env "\${backup_dir}/.env"
fi

if [[ -f deploy/compose/docker-compose.yml ]]; then
  cp deploy/compose/docker-compose.yml "\${backup_dir}/docker-compose.yml"
fi

if [[ -f deploy/compose/.env.prod.example ]]; then
  cp deploy/compose/.env.prod.example "\${backup_dir}/.env.prod.example"
fi

if [[ -f deploy/compose/.env.example ]]; then
  cp deploy/compose/.env.example "\${backup_dir}/.env.example"
fi

if [[ -f deploy/compose/mysql/initdb/30_ry_config_compose_20260610.sql ]]; then
  cp deploy/compose/mysql/initdb/30_ry_config_compose_20260610.sql "\${backup_dir}/30_ry_config_compose_20260610.sql"
fi

{
  echo "release_version=${release_version}"
  echo "backup_label=${backup_label}"
  echo "generated_at=\$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  if command -v docker >/dev/null 2>&1; then
    docker compose --env-file deploy/compose/.env -f deploy/compose/docker-compose.yml images || true
  fi
} > "\${backup_dir}/backup-metadata.txt"

ln -sfn "${backup_label}" backups/latest
echo "compose 快照创建完成：${backup_label}"
EOF

