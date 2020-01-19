#!/usr/bin/env bash

# Clear contents in $HOME/.df/log/pullRepo.log
# 清除 $HOME/.df/log/pullRepo.log 文件中的内容。
truncate -s 0 $HOME/.df/log/pullRepo.log

# Define the function to backup and update a repo.
backup_update()
{
    if [ ! -d $HOME/Documents/$1 ];
    then
        git clone --recursive https://github.com/sierxue/$1.git \
        $HOME/Documents/$1
    fi

    if [ ! -d $HOME/Documents/backup ];
    then
        mkdir $HOME/Documents/backup
        fi
    # Backup the repo to specified directory.
    # cp -r $HOME/Documents/$1 \
    # $HOME/Documents/backup/$1-backup-$(date +%Y-%m-%d-%H:%M)

    # Backup the repo to the 1ast-$1.
    if [ ! -d $HOME/Documents/backup/1ast-$1 ];
    then
        rm -rf $HOME/Documents/backup/1ast-$1
    fi
    cp -r $HOME/Documents/$1 $HOME/Documents/backup/1ast-$1

    # Go to the repository directory
    # 转到仓库所在的目录
    cd $HOME/Documents/$1

    # Discard all untracked files and the unstaged changes.
    # 丢弃掉所有未追踪及未暂存的文件的修改。
    git clean -df
    git clean -dff
    git checkout .

    # Update all the submodules.
    # 更新相关的 submodules
    if [ -f $HOME/Documents/$1/.gitsubmodules ]; then
        git submodule sync --recursive
        git submodule update --remote --recursive
    fi

    # git pull new commits to the repository with rebase option.
    # 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
    git pull --rebase
}

backup_update toolsRes
backup_update beamer-theme-collection
backup_update manuscript-template-collection
