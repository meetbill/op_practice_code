#!/bin/bash
#########################################################################
# File Name: ftptool.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2017-04-23 20:55:02
#########################################################################
allow=YES 
deny=NO 
Sname=vsftpd 
VFconf="/etc/vsftpd/vsftpd.conf"
VFstart="/etc/init.d/vsftpd"
VUser="/etc/vsftpd/vuser"
VUCdirectory="/etc/vsftpd/vuconf"
VFpam="/etc/pam.d/vsftpdd"
VFDirectory="/var/www/html"
DB4=db4 
DB4UTILS="db4-utils"
DB4DEVEL="db4-devel"
sys_tem="/lib64"
http=apache 
#----------主配置文件-------------- 
main_config() 
{ 
    if [ -d $sys_tem ];then
        echo "Your system is 64bit"
        systems=$sys_tem 
    else
        echo "Your system is 32bit"
        systems=/lib
    fi
    #     touch $VFpam 
    sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' $VFconf 
    sed -i 's/#chown_uploads=YES/chown_uploads=NO/g' $VFconf 
    sed -i 's/#xferlog_file/xferlog_file/g' $VFconf 
    sed -i 's/#async_abor_enable=YES/async_abor_enable=YES/g' $VFconf 
    sed -i 's/#ascii_upload_enable=YES/ascii_upload_enable=YES/g' $VFconf 
    sed -i 's/#ascii_download_enable=YES/ascii_download_enable=YES/g' $VFconf 
    sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' $VFconf 
    sed -i 's/pam_service_name=vsftpd/pam_service_name=vsftpdd/g' $VFconf 

    { 
    echo "guest_enable=$allow"
    echo "guest_username=$http"
    echo "user_config_dir=$VUCdirectory"
    echo "virtual_use_local_privs=$allow"
    } >> $VFconf 
    touch $VFpam 
    { 
    echo "auth sufficient $systems/security/pam_userdb.so db=$VUser"
    echo "account sufficient $systems/security/pam_userdb.so db=$VUser"
    } > $VFpam 
} 
#------------用户配置----------------------- 
user_config () 
{ 
    Uname=$1 
    userhome="local_root="
    userworld="anon_world_readable_only="
    userupload="anon_upload_enable="
    usermkdir="anon_mkdir_write_enable="
    userothen="anon_mkdir_write_enable="
    userwrite="write_enable="
    echo -e "\033[31;40m ===Now configure the config file=== \033[0m"
    if [ -d $VUCdirectory ];then
    echo "The directory $VUCdirectory exsits."
    else
    mkdir $VUCdirectory 
    fi
 
    echo "Your want to configure user is :$Uname"
    read -p "Please input user home directory(default $VFDirectory)" home_dir
    if [ "x$home_dir" != "x" ]
    then
    VFDirectory=$home_dir
    fi
    echo "Your home directory is: $VFDirectory"
 
    touch "$VUCdirectory/$Uname"  && echo -e "\033[31;40mSuccess to configure file=== \033[0m"
    { 
    echo "$userhome$VFDirectory"
    echo "$userwrite$allow"
    echo "$userworld$deny"
    echo "$userupload$allow"
    echo "$usermkdir$allow"
    echo "$userothen$allow"
    } > $VUCdirectory/$Uname 
    chown -R $http:$http $VFDirectory 
    chmod -R 755 $VFDirectory 
} 
#----------------增加用户--------------------- 
add_user() 
{ 
    echo "start add user..."
    while [ 1 ]
    do
    isok=y
    echo -n "Do you want to add user?"
    read -p "[Y/N]:" ok
    if [ "x$ok" = "x" ]
    then
        continue
    elif [ "x$ok" = "xN" ]
    then
        echo "=============Finish add user============="
        break
    fi
    isok=$ok
    if [ "x$isok" != "xY" ]
    then
        echo "Error input! please input Y/N "
        continue
    else
        read -p "Input username: " username
        read -p "Input userpasswd: " userpasswd
        echo "Your username is: $username"
        echo "Your userpasswd is: $userpasswd"
        { 
        echo "$username"
        echo "$userpasswd"
        } >> $VUser 
        user_config $username
    fi
    done
    db_load -T -t hash -f  $VUser $VUser.db 
} 
#-----------------安装服务--------------------- 
install_server() 
{ 
    rpm -q $Sname 
    if [ $? -eq 0 ];then
    echo "vsftpd service has installed. "
    else
    yum install -y $Sname 
    fi
    yum -y install "db4*"
} 
#------------------------------------------------ 
case $1 in
    install_server)
    echo "start install $Sname:"
    install_server
    main_config 
    ;;
    add_user)
    add_user
    ;;
    restart)
    $VFstart restart
    ;;
    start)
    $VFstart start 
    ;;
    stop)
    $VFstart stop
    ;;
    *)
    echo "Usage: $0 install_server|add_user|restart|start|stop"
    exit 1
esac
 
exit 0

