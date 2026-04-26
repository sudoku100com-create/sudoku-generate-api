#!/bin/bash

# GitHub 提交快捷脚本
# 用于快速提交 Sudoku API 开源项目到 GitHub

echo "=== Sudoku API 开源项目提交脚本 ==="

# 检查是否在正确的目录
if [ ! -f "README.md" ]; then
    echo "错误: 请在项目根目录运行此脚本"
    exit 1
fi

# 检查 git 是否已初始化
if [ ! -d ".git" ]; then
    echo "初始化 git 仓库..."
    git init
    git remote add origin https://github.com/sudoku100com-create/Sudoku-generate-API.git
    echo "已初始化 git 仓库并添加远程地址"
fi

# 添加所有文件
echo "添加文件到暂存区..."
git add .

# 提示输入提交信息
echo "请输入提交信息:"
read commit_message

# 提交更改
echo "提交更改..."
git commit -m "$commit_message"

# 推送到 GitHub
echo "推送到 GitHub..."
git push -u origin main

echo "
=== 提交完成 ==="
echo "项目已成功提交到 GitHub!"
echo "仓库地址: https://github.com/sudoku100com-create/Sudoku-generate-API"
