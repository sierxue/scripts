#!/usr/bin/env bash

# Clear contents in ~/.df/log/pullDotfiles.log
# 清除 ~/.df/log/pullDotfiles.log 文件中的内容。
truncate -s 0 ~/.df/log/pullDotfiles.log

# Go to the repository directory
# 转到仓库所在的目录
cd ~/.df/dotfiles

# Discard all the unstaged changes made to the repository.
# 丢弃掉所有未暂存的文件的修改。
git checkout .

# Update all the submodules.
# 更新相关的 submodules
git submodule sync --recursive
git submodule update --remote --recursive

# git pull new commits to the repository with rebase option..
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase

# Reinstall soft links.
# 重新安装软链接
./install

# Go to the repository directory
# 转到仓库所在的目录
cd ~/.df/dotfiles-local

# Discard all the unstaged changes made to the repository.
# 丢弃掉所有未暂存的文件的修改。
git checkout .

# Update all the submodules.
# 更新相关的 submodules
git submodule sync --recursive
git submodule update --remote --recursive

# git pull new commits to the repository with rebase option..
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase

# Reinstall soft links.
# 重新安装软链接
./install
