## 命令行提示 Git 信息

### 1 下载
```
#curl -o ~/.bash_git_ps1.sh https://raw.githubusercontent.com/xtrementl/dev-bash-git-ps1/master/bash_git_ps1.sh
```

### 2 将如下行放到.bash_profile 文件中 

```
if [ -f ~/.bash_git_ps1.sh  ]; then 
. ~/.bash_git_ps1.sh 
fi 
```
### 3 将其立即生效
```
source ~/.bash_profile
```

**[原 git 地址](https://github.com/xtrementl/dev-bash-git-ps1)**
