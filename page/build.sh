#!/bin/bash
# 清除所有内容，从npm重新下载
rm -rf node_modules package-lock.json
npm install
npm install hexo
# 构建hexo
npx hexo clean
npx hexo generate

