# open the directory
# 打开 dotfiles 目录
cd ~/.df/dotfiles

# Discard all the unstaged changes made to the repository.
# 丢弃掉所有未暂存的文件的修改。
git checkout .

# git pull new commits to the repository with rebase option..
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase

# Update all the submodules recursively.
# 更新所有相关的 submodules
git submodule update --remote --recursive
# open the directory

# 打开 dotfiles-local 目录
cd ~/.df/dotfiles-local

# Discard all the unstaged changes made to the repository.
# 丢弃掉所有未暂存的文件的修改。
git checkout .

# git pull new commits to the repository with rebase option..
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase

# Update all the submodules recursively.
# 更新所有相关的 submodules
git submodule update --remote --recursive
