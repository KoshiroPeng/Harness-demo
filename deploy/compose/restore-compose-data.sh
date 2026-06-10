#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于从远端数据备份归档恢复 MySQL、Redis、Nacos 日志和上传目录。
# 恢复前会停止 compose 容器，恢复完成后重新拉起并执行最小验证。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base-compose}"
data_restore_backup="${DATA_RESTORE_BACKUP:-}"
dry_run="${DRY_RUN:-true}"
file_upload_path="${FILE_UPLOAD_PATH_OVERRIDE:-}"

if [[ -z "${data_restore_backup}" ]]; then
  echo "缺少 DATA_RESTORE_BACKUP，无法执行 compose 数据恢复。" >&2
  exit 1
fi

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" ]]; then
  echo "缺少 compose 数据恢复所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出 compose 数据恢复计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 目标数据备份：${data_restore_backup}"
  exit 0
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "远端恢复 compose 数据备份：${data_restore_backup}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"

backup_root="data-backups/${data_restore_backup}"
if [[ ! -d "\${backup_root}" ]]; then
  echo "未找到 compose 数据备份目录：\${backup_root}" >&2
  exit 1
fi

bash deploy/compose/manage-compose.sh down || true

if [[ -f "\${backup_root}/mysql-data.tar.gz" ]]; then
  rm -rf deploy/compose/data/mysql
  mkdir -p deploy/compose/data
  tar -xzf "\${backup_root}/mysql-data.tar.gz" -C deploy/compose/data
fi

if [[ -f "\${backup_root}/redis-data.tar.gz" ]]; then
  rm -rf deploy/compose/data/redis
  mkdir -p deploy/compose/data
  tar -xzf "\${backup_root}/redis-data.tar.gz" -C deploy/compose/data
fi

if [[ -f "\${backup_root}/nacos-data.tar.gz" ]]; then
  rm -rf deploy/compose/data/nacos
  mkdir -p deploy/compose/data
  tar -xzf "\${backup_root}/nacos-data.tar.gz" -C deploy/compose/data
fi

if [[ -n "${file_upload_path}" && -f "\${backup_root}/file-upload-data.tar.gz" ]]; then
  rm -rf "${file_upload_path}"
  mkdir -p "${file_upload_path}"
  tar -xzf "\${backup_root}/file-upload-data.tar.gz" -C "${file_upload_path}"
fi

bash deploy/compose/manage-compose.sh up-all
bash deploy/compose/manage-compose.sh verify
echo "compose 数据恢复完成：${data_restore_backup}"
EOF

