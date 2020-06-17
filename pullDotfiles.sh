#!/usr/bin/env bash

# Clear contents in ~/.df/log/pullDotfiles.log
# 清除 ~/.df/log/pullDotfiles.log 文件中的内容。
if [ ! -d ~/.df/log/ ]; then
    mkdir ~/.df/log
else truncate -s 0 ~/.df/log/pullDotfiles.log
fi

# Update cron job if there is an update.
crontab -u ganx ~/.df/dotfiles/scripts/config/crontab
sudo /etc/init.d/cron restart

update_repo_and_submodules()
{
    # Discard all the unstaged changes made to the repository.
    # 丢弃掉所有未暂存的文件的修改。
    git clean -df
    git clean -dff
    git checkout .

    # Update all the submodules.
    # 更新相关的 submodules
    git submodule sync --recursive
    git submodule update --remote --recursive

    # git pull new commits to the repository with rebase option..
    # 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
    git pull --rebase
}

# Go to the repository directory
# 转到仓库所在的目录
cd ~/.df/dotfiles
# Update the repo and all submodules recursively.
update_repo_and_submodules
# Reinstall soft links.
# 重新安装软链接
./install

# Go to the repository directory
# 转到仓库所在的目录
cd ~/.df/dotfiles-local
# Update the repo and all submodules recursively.
update_repo_and_submodules
# Reinstall soft links.
# 重新安装软链接
./install

# Update zsh-autosuggestions
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ];
then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git pull    
fi


# Update zsh-completions
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ];
then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
    git pull
fi

# Update zsh-syntax-highlighting
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ];
then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git pull
fi

# Update theme spaceship-prompt
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt ];
then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
    git pull
fi
