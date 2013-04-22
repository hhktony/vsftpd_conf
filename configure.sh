#!/usr/bin/env bash

#============================================================================================
#
#         FileName: configure.sh
#
#      Descriptions:
#
#          Version: 1.0
#          Created: 2013-04-22 10:24:58
#         Revision: (none)
#
#           Author: xutao(mark), butbueatiful@gmail.com
#          Company: wanwei-tech
#
#============================================================================================
 

# set -x

BACKUP_DATE=`date +%F`
FTP_NAME="ftp"
FTP_VUSERS_NAME="ftpvuser"
FTP_CONF_DIR="/etc/vsftpd"
FTP_ROOT_DIR="/var/$FTP_NAME"
FTP_VUSERS_CONF_DIR="/etc/vsftpd/vusers_conf"
FTP_VUSERS_ROOT_DIR="/var/$FTP_VUSERS_NAME"
PAM_CONF_DIR="/etc/pam.d"

if [ $# == 0 ];then
    printf "\e[01;31m Usage: $0 <init/adduser>\E[0m\n\n" 
    exit 1;
fi

add_user()
{
    db_load -T -t hash -f $FTP_CONF_DIR/vusers $FTP_CONF_DIR/vusers.db

    #sed -n 'n;p' filename # 取偶数行
    for x in `sed -n 'p;n' $FTP_CONF_DIR/vusers` # 取奇数行
    do
        if [ ${x##*.} = "r_w" ]; then
            cp $FTP_VUSERS_CONF_DIR/Templates/vuser_conf.r_w $FTP_VUSERS_CONF_DIR/$x
        else
            cp $FTP_VUSERS_CONF_DIR/Templates/vuser_conf.r $FTP_VUSERS_CONF_DIR/$x
        fi

        sed -i "s/vuser_name/${x}/" $FTP_VUSERS_CONF_DIR/$x
        mkdir -p $FTP_VUSERS_ROOT_DIR/$x
    done

    chown -R $FTP_VUSERS_NAME.$FTP_VUSERS_NAME $FTP_VUSERS_ROOT_DIR
}

if [ "$1" = "adduser" ]; then
    add_user
    exit
fi

cp -r $FTP_CONF_DIR $FTP_CONF_DIR.$BACKUP_DATE.bak
cp $PAM_CONF_DIR/vsftpd $PAM_CONF_DIR/vsftpd.bak
rm -rf $FTP_CONF_DIR/*

for name in `ls`
do
    cp $name $FTP_CONF_DIR -r
done

mv $FTP_CONF_DIR/pam_vsftpd $PAM_CONF_DIR/vsftpd
#rm $FTP_CONF_DIR/`basename $0`

touch /var/log/vsftpd.log > /dev/zero 2>&1

cd $FTP_CONF_DIR

useradd $FTP_NAME -d $FTP_ROOT_DIR -s /sbin/nologin > /dev/zero 2>&1
useradd $FTP_VUSERS_NAME -d $FTP_VUSERS_ROOT_DIR -s /sbin/nologin > /dev/zero 2>&1

add_user
