#!/bin/bash
# recieve 2 parameter form command line , device name and record file name
# make full check of all disk if no parameters given 

function smartctl_self_check()
{
    local disk=$1
    local slog=$2
    echo -n "$disk:"
    if [[ -f $slog ]];then
        grep -i "self-assessment test" $slog | grep -E "OK|PASSED" &>/dev/null
    else
        smartctl -H $disk | grep -E "OK|PASSED" &>/dev/null
    fi
    if [[ $? -ne 0 ]];then
        echo -e "\e[1;31mFAILED\e[0m"
    else
        echo -e "\e[1;32mPASS\e[0m"
    fi
}

function smartctl_para_check()
{
    local drive=$1
    local slog=$2
    local bn=`basename $1`
    if [[ ! -f $slog ]];then
        local slog=/tmp/smartctl-a-$bn
        smartctl -a $drive &> $slog
    fi
    local value="$1     "
    for p in ${para[@]};do
        tvalue=$(grep -i $p $slog | xargs |cut -d " " -f10)
        if [[ $tvalue == "" ]];then
            tvalue="-"
        fi
        value="$value         $tvalue         "
    done
    echo "$value"
}

dlog=""
device=""

while getopts 'd:f:h' OPT;do
    case $OPT in
        d)
            device="$OPTARG";;
        f)
            dlog="$OPTARG";;
        h)
            echo "Usage:bash $0 -d devicename -f logfile";
            exit 1;;
        ?)
            echo "Usage:bash $0 -d devicename -f logfile";
            exit 1;;
    esac
done

            
disklist=(`ls /dev/[sh]d* | tr -d "[0-9]+$" | uniq`)
p1="Reallocated_Sector_Ct"
p2="Command_Timeout"
p3="Current_Pending_Sector"
p4="Reallocated_Event_Count"
p5="Offline_Uncorrectable"
para=( $p1 $p2 $p3 $p4 $p5 )

if [[ $device != "" ]];then
    ls $device &>/dev/null 
    if [[ $? -ne 0 ]];then
        if [[ $dlog == "" ]];then
            echo "Device $device not found!"
            exit 1
        fi
    fi
    echo -e "\e[1;34m\nSmartctl self-test:\e[0m"
    smartctl_self_check $device $dlog
    echo -e "\e[1;34m\nSmartctl key parameter:\e[0m"
    echo -e "\e[1;34mdrive    ${para[@]}\e[0m"
    smartctl_para_check $device $dlog
else
    # 默认执行以下程序
    echo -e "\e[1;34m\nSmartctl self-test:\e[0m"
    for d in ${disklist[@]};do
        smartctl_self_check $d
    done
    echo -e "\e[1;34m\nSmartctl key parameter:\e[0m"
    echo -e "\e[1;34mdrive    ${para[@]}\e[0m"
    for d in ${disklist[@]};do
        smartctl_para_check $d
    done
fi
