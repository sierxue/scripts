#!/usr/bin/env bash

# Clear contents in ~/.df/log/pullRepositories.log
# 清除 ~/.df/log/pullRepositories.log 文件中的内容。
truncate -s 0 ~/.df/log/pullRepositories.log

# Go to the repository directory
# 转到仓库所在的目录
cd ~/repo/toolsRes

# Discard all untracked files and the unstaged changes made to the repository.
# 丢弃掉所有未追踪及未暂存的文件的修改。
git clean -df
git clean -dff
git checkout -- elegantbook_sierxue.cls
git checkout -- toolsRes.tex
git checkout .

# git pull new commits to the repository with rebase option.
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase
