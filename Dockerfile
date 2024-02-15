FROM registry.openanolis.cn/openanolis/nginx:1.14.1-8.6

# 安装 fcgiwrap 和其他依赖
RUN yum install -y epel-release && yum install -y fcgiwrap && yum clean all

# 创建 cgi-bin 目录
RUN mkdir -p /usr/lib/cgi-bin

# 添加脚本文件
COPY cpu_architecture.sh /usr/lib/cgi-bin/cpu_architecture.sh

# 确保脚本是可执行的
RUN chmod +x /usr/lib/cgi-bin/cpu_architecture.sh

# 添加 Nginx 配置
COPY cpu_architecture.conf /etc/nginx/default.d/cpu_architecture.conf

# 暴露端口
EXPOSE 80

# 启动 Nginx (基于基础镜像的启动命令)
CMD ["nginx", "-g", "daemon off;"]

