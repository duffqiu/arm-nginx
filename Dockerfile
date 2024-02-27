FROM registry.openanolis.cn/openanolis/nginx:1.14.1-8.6


# 安装 fcgiwrap spawn-fcgi 和其他依赖
RUN yum install -y epel-release && yum install -y fcgiwrap spawn-fcgi && yum clean all

RUN touch /var/run/fcgiwrap.socket && chown nginx:nginx /var/run/fcgiwrap.socket && chmod 660 /var/run/fcgiwrap.socket

# 创建 cgi-bin 目录
RUN mkdir -p /usr/lib/cgi-bin

# 添加脚本文件
COPY cpu_architecture.sh /usr/lib/cgi-bin/cpu_architecture.sh
COPY fetch_content.sh /usr/lib/cgi-bin/fetch_content.sh

# 确保脚本是可执行的
RUN chmod +x /usr/lib/cgi-bin/cpu_architecture.sh
RUN chmod +x /usr/lib/cgi-bin/fetch_content.sh

# 添加 Nginx 配置
COPY cpu_architecture.conf /etc/nginx/default.d/cpu_architecture.conf
COPY fetch_content.conf /etc/nginx/default.d/fetch_content.conf

# 暴露端口
EXPOSE 80

# 创建一个启动脚本来同时启动 fcgiwrap 和 Nginx
RUN echo '#!/bin/bash' > /start.sh \
    && echo 'spawn-fcgi -s /var/run/fcgiwrap.socket -u nginx -g nginx -- /usr/sbin/fcgiwrap &' >> /start.sh \
    && echo 'nginx -g "daemon off;"' >> /start.sh \
    && chmod +x /start.sh

# 设置卷，以便可以从主机挂载 CGI 脚本
VOLUME /usr/lib/cgi-bin

# 启动 Nginx (基于基础镜像的启动命令)
CMD ["/start.sh"]

