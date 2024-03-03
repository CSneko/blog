#!/bin/bash
# 清除所有内容，从npm重新下载
rm -rf node_modules package-lock.json
npm install
npm install hexo
# 构建hexo
npx hexo clean
npx hexo generate
# 删除无用文件
find . -mindepth 1 -not -path "./public" -not -path "./public/*" -exec rm -rf {} +
# 移动文件
mv ./public/* ./
