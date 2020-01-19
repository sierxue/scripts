#!/usr/bin/env bash

# Clear contents in $HOME/.df/log/pullRepo.log
# 清除 $HOME/.df/log/pullRepo.log 文件中的内容。
truncate -s 0 $HOME/.df/log/pullRepo.log

if [ ! -d $HOME/Documents/toolsRes ];
then
    git clone --recursive https://github.com/sierxue/toolsRes.git \
    $HOME/Documents/toolsRes
fi

# Backup the repo to specified directory.
# if [ ! -d $HOME/Documents/backup/toolsRes-backup ];
# then
#     rm -rf $HOME/Documents/backup/toolsRes-backup
# fi
if [ ! -d $HOME/Documents/backup ];
then
    mkdir $HOME/Documents/backup
fi
cp -r $HOME/Documents/toolsRes \
$HOME/Documents/backup/toolsRes-backup-$(date +%Y-%m-%d-%H:%M)

# Go to the repository directory
# 转到仓库所在的目录
cd $HOME/Documents/toolsRes

# Discard all untracked files and the unstaged changes made to the repository.
# 丢弃掉所有未追踪及未暂存的文件的修改。
git clean -df
git clean -dff
git checkout .

# git pull new commits to the repository with rebase option.
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase
