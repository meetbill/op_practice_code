#!/bin/bash
#########################################################################
# File Name: speedtest-tool.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2017-09-17 21:28:21
#########################################################################
FILENAME=./china_num
SPEEDTEST_LOG=/home/speedtest.log
SPEEDTEST_LOG_ONE=/home/speedtest_one.log

if [[ ! -e ./speedtest-cli  ]]
then
    echo "not found speedtest"
fi
chmod +x ./speedtest-cli

function speed_test()
{
    while true
    do
        cat $FILENAME | while read LINE
        do
            echo "" >> $SPEEDTEST_LOG
            echo $(date +"%Y-%m-%d,%H:%M:%S") $LINE >> ${SPEEDTEST_LOG}
            ./speedtest-cli --server $LINE >> ${SPEEDTEST_LOG}
            
        done
    done
}

function create_num()
{
    ./speedtest-cli --list | grep China | grep -v "Hong Kong"> china
    awk -F ')' '{print $1}' china > china_num

}

function speed_one()
{

    > ${SPEEDTEST_LOG_ONE}
    LOOP=1
    cat $FILENAME | while read LINE
    do
        echo "" >> $SPEEDTEST_LOG_ONE
        echo "$LOOP:  $LINE"
        LOOP=`expr $LOOP + 1`

        echo $(date +"%Y-%m-%d,%H:%M:%S") $LINE >> ${SPEEDTEST_LOG_ONE}
        ./speedtest-cli --server $LINE --no-download >> ${SPEEDTEST_LOG_ONE}
            
    done
}

name=`basename $0`  
case $1 in  
 create)  
        echo "create num..."  
        create_num
        ;;  
 one)  
        echo "start one..."  
        speed_one
        ;;  
 test)  
        echo "start test ..."  
        speed_test
        ;;  
 *)  
        echo "Usage: $name [create|one|test]"  
        exit 1  
        ;;  
esac  
exit 0
