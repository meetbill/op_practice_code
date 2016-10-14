#########################################################################
# File Name: s3_upload.sh
# Author: Bill
# mail: XXXXXX
# Funtion: 使用curl上传文件到公共s3
# Created Time: 2016-10-14 21:59:08
#########################################################################
#!/bin/bash
#
if [[ $# != 2 ]]
then
    echo "usage:sh s3_upload.sh BUCKET_NAME file_path"
    exit
fi

BUCKET_NAME=$1
PATH_FILE=$2
FILE_NAME=`basename ${PATH_FILE}`
echo $FILE_NAME
curl -X PUT -T $PATH_FILE "http://s3.cn-north-1.amazonaws.com.cn/${BUCKET_NAME}/${FILE_NAME}"
