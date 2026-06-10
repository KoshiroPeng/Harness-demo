# 中文说明：该 Dockerfile 用于统一构建各个后端微服务运行镜像。
# 通过 APP_JAR_FILE 构建参数指定具体模块的 Jar，避免为每个服务重复维护一份 Dockerfile。

FROM eclipse-temurin:17-jre-jammy

ARG APP_JAR_FILE

# 中文说明：curl 用于健康检查，netcat 用于入口脚本等待 Nacos 可达。
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/harness-base

COPY ${APP_JAR_FILE} /opt/harness-base/app.jar
COPY deploy/compose/docker/backend-entrypoint.sh /opt/harness-base/backend-entrypoint.sh

RUN chmod +x /opt/harness-base/backend-entrypoint.sh

ENV APP_JAR_PATH=/opt/harness-base/app.jar
ENV WAIT_FOR_HOST=ruoyi-nacos
ENV WAIT_FOR_PORT=8848
ENV WAIT_TIMEOUT_SECONDS=180
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

ENTRYPOINT ["/opt/harness-base/backend-entrypoint.sh"]

