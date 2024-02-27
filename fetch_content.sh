#!/bin/bash

# 设置 Content-type 为 text/plain 或者适当的 MIME 类型
printf "Content-Type: text/html; charset=utf-8\n\n"

# 假设 urls.txt 是包含 URL 的本地文件
# 你可以在这里添加逻辑以确定要读取哪个 URL，例如使用参数或者特定的行
URL=$(head -n 1 ./oururl.txt)

# 使用 curl 获取页面内容
curl -s "$URL" -k
