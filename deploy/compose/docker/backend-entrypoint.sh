#!/usr/bin/env sh

set -eu

# 中文说明：该入口脚本用于在微服务启动前等待 Nacos 可访问，
# 避免 docker compose 仅保证启动顺序、但配置中心尚未就绪时服务直接失败。

wait_for_host="${WAIT_FOR_HOST:-}"
wait_for_port="${WAIT_FOR_PORT:-}"
wait_timeout_seconds="${WAIT_TIMEOUT_SECONDS:-180}"
app_jar_path="${APP_JAR_PATH:-/opt/harness-base/app.jar}"
java_opts="${JAVA_OPTS:-}"

if [ -n "${wait_for_host}" ] && [ -n "${wait_for_port}" ]; then
  echo "等待依赖服务就绪：${wait_for_host}:${wait_for_port}"
  remaining_seconds="${wait_timeout_seconds}"

  while ! nc -z "${wait_for_host}" "${wait_for_port}" >/dev/null 2>&1; do
    remaining_seconds=$((remaining_seconds - 1))

    if [ "${remaining_seconds}" -le 0 ]; then
      echo "等待依赖服务超时：${wait_for_host}:${wait_for_port}" >&2
      exit 1
    fi

    sleep 1
  done
fi

echo "启动应用：${app_jar_path}"
exec sh -c "java ${java_opts} -jar \"${app_jar_path}\""

