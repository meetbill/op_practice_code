## speedtest

## 1 使用

```
# 生成中国节点 server num
#bash speedtest-tool.sh create

# 在 screen 中执行如下命令
#bash speedtest-tool.sh test
```

## 2 结果生成

### 2.1 ping

进入到 /home 目录
```
#grep Hosted speedtest.log| grep -v 1800000 | awk -F ':' '{print $2}'  | awk -F ' ' '{print $1}'|sort -n >> ping
```

### 2.2 download

进入到 /home 目录
```
#grep Download speedtest.log | awk -F ':| ' '{print $3}' | sort -n -r |grep -v 0.00 > download
```

### 2.3 upload
进入到 /home 目录
```
#grep Upload speedtest.log | awk -F ':| ' '{print $3}' | sort -n -r| grep -v 0.00 > upload
```

## 3 数据统计

统计对应文件中的前多少行的平均值
```
#head -n 3433 upload | awk '{ sum += $1;  } END { print "sum = " sum; print "average = " sum/NR  }'
```
