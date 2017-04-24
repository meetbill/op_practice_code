#!/bin/bash
#########################################################################
# File Name: inotify_rsync.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2017-04-23 23:53:20
# soft:inotify-tools
# 清理1M以上的日志
#########################################################################
host=192.168.1.59
user=root
# 服务器存储目录
src='/tmp/src1/'
# 存储数据异地灾备目录
dest='/tmp/dest1'
rsync_log='/tmp/rsync.log'

inotifywait -mrq -e modify,attrib,moved_to,moved_from,move,move_self,create,delete,delete_self --timefmt='%d/%m/%y %H:%M' --format='%T %w%f %e' $src | while read chgeFile
do
    [[ $(wc -c ${rsync_log} | awk '{print $1}') -gt 1024000 ]]  &&  $(>${rsync_log})
    rsync -avPz  $src $user@$host:$dest &>>${rsync_log}
done

