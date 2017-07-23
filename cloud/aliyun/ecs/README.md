## 使用说明

```
第一步，请安装python 2.x版本。Windows/Linux/MacOS等操作系统中如何安装本文不再描述。 
 
第二步，从这里的链接https://aliyunecs.oss.aliyuncs.com/tools/ecs.py 下载地址下载ecs.py脚本
$ chmod +x ./ecs.py 
加上执行权限后使用更加方便。 
 
第三步，访问http://i.aliyun.com/access_key，点击“创建AccessKey”创建一个accesskeyid/accesskeysecret密钥对。请保存这个密钥对，这是非常重要敏感的信息，绝不能泄漏。  
接下来，在终端中直接执行ecs.py这个脚本，可以看到它的帮助信息，我们首先需要将刚刚获取到的密钥对配置好。使用以下命令来进行配置： 
$./ecs.py config --id=<access key id> --secret=<access key secret> 
配置完成后，可以执行列出可用地域(Region)命令来验证是否配置成功： 
$./ecs.py DescribeRegions 
如果配置的密钥对没有问题，那么这个命令会输出一个json格式的结果，包含了杭州(cn-hangzhou)和青岛(cn-qingdao)两个地域的信息。 
 
第四步，从http://help.aliyun.com/list/11113464.html下载ECS API文档，作为后续使用的参考。 

```
## 例子

### 查看实例列表
```
python ecs.py DescribeInstances RegionId=cn-qingdao

# 实例详细信息
python ecs.py DescribeInstanceStatus RegionId=cn-qingdao 

```

### 启动和关闭实例

```
python ecs.py StartInstance InstanceId=i-xxxxxxxxxxx
python ecs.py StopInstance InstanceId=i-xxxxxxxxxxx

```

