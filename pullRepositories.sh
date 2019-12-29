# Clear contents in ~/.df/log/pullRepositories.log
# 清除 ~/.df/log/pullRepositories.log 文件中的内容。
truncate -s 0 ~/.df/log/pullRepositories.log

# Go to the repository directory
# 转到仓库所在的目录
cd ~/repo/toolsRes

# Discard all the unstaged changes made to the repository.
# 丢弃掉所有未暂存的文件的修改。
git checkout .

# git pull new commits to the repository with rebase option.
# 用带 rebase 选项的 git pull 更新这个仓库所有的新提交。
git pull --rebase
