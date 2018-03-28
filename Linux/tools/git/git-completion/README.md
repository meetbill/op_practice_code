## Git 自动补全

### 1 下载
下载git-completion.bash 并放到home 目录下
```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash 
```

### 2 将如下行放到.bash_profile 文件中 

```
if [ -f ~/.git-completion.bash  ]; then 
. ~/.git-completion.bash 
fi 
```
### 3 将其立即生效
```
source ~/.bash_profile
```

**[原 git 地址](https://github.com/git/git/tree/master/contrib/completion)**
