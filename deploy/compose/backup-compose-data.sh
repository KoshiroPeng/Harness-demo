#!/usr/bin/env bash

set -euo pipefail

# 中文说明：该脚本用于在远端对 compose 数据目录做主机级归档备份。
# 备份范围包含 MySQL、Redis、Nacos 日志和文件上传目录，不覆盖代码与编排文件快照。

target_host="${APP_DEPLOY_HOST:-}"
target_user="${APP_DEPLOY_USER:-}"
target_key="${APP_DEPLOY_KEY:-}"
target_port="${APP_DEPLOY_PORT:-22}"
target_dir="${APP_DEPLOY_DIR:-/opt/harness-base-compose}"
dry_run="${DRY_RUN:-true}"
data_backup_label="${DATA_BACKUP_LABEL:-$(date -u +%Y%m%dT%H%M%SZ)-data}"
stop_before_backup="${STOP_BEFORE_BACKUP:-true}"
file_upload_path="${FILE_UPLOAD_PATH_OVERRIDE:-}"

if [[ -z "${target_host}" || -z "${target_user}" || -z "${target_key}" ]]; then
  echo "缺少 compose 数据备份所需环境变量：APP_DEPLOY_HOST / APP_DEPLOY_USER / APP_DEPLOY_KEY。" >&2
  exit 1
fi

if [[ "${dry_run}" == "true" ]]; then
  echo "当前为 dry-run，输出 compose 数据备份计划："
  echo "- 目标主机：${target_user}@${target_host}:${target_dir}"
  echo "- 备份标签：${data_backup_label}"
  echo "- 备份前停止容器：${stop_before_backup}"
  exit 0
fi

key_file="$(mktemp)"
cleanup() {
  rm -f "${key_file}"
}
trap cleanup EXIT

printf '%s' "${target_key}" > "${key_file}"
chmod 600 "${key_file}"

echo "远端创建 compose 数据备份：${data_backup_label}"
ssh -i "${key_file}" -p "${target_port}" -o StrictHostKeyChecking=no "${target_user}@${target_host}" <<EOF
set -euo pipefail
cd "${target_dir}"

backup_root="data-backups/${data_backup_label}"
mkdir -p "\${backup_root}"

if [[ "${stop_before_backup}" == "true" ]]; then
  bash deploy/compose/manage-compose.sh down || true
fi

if [[ -d deploy/compose/data/mysql ]]; then
  tar -czf "\${backup_root}/mysql-data.tar.gz" -C deploy/compose/data mysql
fi

if [[ -d deploy/compose/data/redis ]]; then
  tar -czf "\${backup_root}/redis-data.tar.gz" -C deploy/compose/data redis
fi

if [[ -d deploy/compose/data/nacos ]]; then
  tar -czf "\${backup_root}/nacos-data.tar.gz" -C deploy/compose/data nacos
fi

if [[ -n "${file_upload_path}" && -d "${file_upload_path}" ]]; then
  tar -czf "\${backup_root}/file-upload-data.tar.gz" -C "${file_upload_path}" .
fi

{
  echo "data_backup_label=${data_backup_label}"
  echo "generated_at=\$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "stop_before_backup=${stop_before_backup}"
  echo "file_upload_path=${file_upload_path}"
} > "\${backup_root}/backup-metadata.txt"

ln -sfn "${data_backup_label}" data-backups/latest
echo "compose 数据备份完成：${data_backup_label}"
EOF

