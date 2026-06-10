#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于把远端 compose 部署目录恢复到指定备份快照，
# 然后重新执行 docker compose build/up/verify。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base-compose}"
rollback_backup="${ROLLBACK_BACKUP:-}"
rollback_reason="${ROLLBACK_REASON:-未提供原因}"
dry_run="${DRY_RUN:-true}"

if [[ -z "${rollback_backup}" ]]; then
  echo "缺少 ROLLBACK_BACKUP，无法执行 compose 回滚。" >&2
  exit 1
fi

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" ]]; then
  echo "缺少 compose 回滚所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出 compose 回滚计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 目标快照：${rollback_backup}"
  echo "- 回滚原因：${rollback_reason}"
  exit 0
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "远端恢复 compose 快照：${rollback_backup}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"

backup_dir="backups/${rollback_backup}"
if [[ ! -d "\${backup_dir}" ]]; then
  echo "未找到 compose 回滚快照：\${backup_dir}" >&2
  exit 1
fi

if [[ -f "\${backup_dir}/.env" ]]; then
  cp "\${backup_dir}/.env" deploy/compose/.env
fi

if [[ -f "\${backup_dir}/docker-compose.yml" ]]; then
  cp "\${backup_dir}/docker-compose.yml" deploy/compose/docker-compose.yml
fi

if [[ -f "\${backup_dir}/.env.prod.example" ]]; then
  cp "\${backup_dir}/.env.prod.example" deploy/compose/.env.prod.example
fi

if [[ -f "\${backup_dir}/.env.example" ]]; then
  cp "\${backup_dir}/.env.example" deploy/compose/.env.example
fi

if [[ -f "\${backup_dir}/30_ry_config_compose_20260610.sql" ]]; then
  cp "\${backup_dir}/30_ry_config_compose_20260610.sql" deploy/compose/mysql/initdb/30_ry_config_compose_20260610.sql
fi

bash deploy/compose/manage-compose.sh build-images
bash deploy/compose/manage-compose.sh up-all
bash deploy/compose/manage-compose.sh verify
echo "compose 回滚完成：${rollback_backup}"
echo "回滚原因：${rollback_reason}"
EOF

