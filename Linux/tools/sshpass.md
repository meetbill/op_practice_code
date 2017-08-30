## sshpass

<!-- vim-markdown-toc GFM -->
* [下周](#下周)
* [源码编译安装](#源码编译安装)
* [使用](#使用)

<!-- vim-markdown-toc -->

### 下周

本目录有 sshpass 源码文件

### 源码编译安装

```
tar -zxvf sshpass-1.06.tar.gz
cd sshpass-1.06
./configure
make
make install
```
### 使用
```
sshpass -p 123456 ssh root@10.0.0.37 -o StrictHostKeyChecking=no
后面这个是“Are you sure you want to continue connecting (yes/no)”使得这个自动接受，若不加，则成功不了
```
注：此编译后的包在 cetnos 6.5 / suse 12 通用，无需再次编译

