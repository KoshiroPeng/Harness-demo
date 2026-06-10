# 中文说明：该 Dockerfile 负责封装前端静态资源和反向代理配置。
# 约定先在宿主机执行 npm run build:prod，生成的 web/dist 再被复制进镜像。

FROM nginx:1.27-alpine

COPY deploy/compose/nginx/nginx.conf /etc/nginx/nginx.conf
COPY web/dist /usr/share/nginx/html

