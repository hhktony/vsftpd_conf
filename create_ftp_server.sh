#!/usr/bin/env bash

#============================================================================================
#
#         FileName: create_ftp_server.sh
#
#      Descriptions:
#
#          Version: 1.0
#          Created: 2013-04-15 14:44:41
#         Revision: (none)
#
#           Author: xutao(mark), butbueatiful@gmail.com
#          Company: wanwei-tech
#
#============================================================================================
 
#set -x

BACKUP_DATE=`date +%F`
FTP_NAME="ftp"
FTP_VIRTUSER_NAME="ftpvirtuser"
FTP_CONF_DIR="/etc/vsftpd"
FTP_ROOT_DIR="/var/$FTP_NAME"
FTP_VIRTUSER_CONF_DIR="/etc/vsftpd/virtuser_conf"
FTP_VIRTUSER_ROOT_DIR="/var/$FTP_VIRTUSER_NAME"
PAM_CONF_DIR="/etc/pam.d"

cp -r $FTP_CONF_DIR $FTP_CONF_DIR.$BACKUP_DATE.bak
rm -rf $FTP_CONF_DIR/*

for name in `ls`
do
    cp $name $FTP_CONF_DIR -r
done

mv $FTP_CONF_DIR/pam_vsftpd $PAM_CONF_DIR/vsftpd
rm $FTP_CONF_DIR/`basename $0` $FTP_CONF_DIR/README.md

cd $FTP_CONF_DIR

useradd ftp -d $FTP_ROOT_DIR -s /sbin/nologin > /dev/zero 2>&1
useradd -d $FTP_VIRTUSER_ROOT_DIR -s /sbin/nologin ftpvirtuser > /dev/zero 2>&1

db_load -T -t hash -f $FTP_CONF_DIR/virtusers $FTP_CONF_DIR/virtusers.db

#sed -n 'n;p' filename # 取偶数行
for x in `sed -n 'p;n' virtusers`
do
    #echo $x

    if [ ${x##*.} = "r_w" ]; then
        cp $FTP_VIRTUSER_CONF_DIR/virtuser_conf.r_w $FTP_VIRTUSER_CONF_DIR/$x
    else
        cp $FTP_VIRTUSER_CONF_DIR/virtuser_conf.r $FTP_VIRTUSER_CONF_DIR/$x
    fi

    sed -i "s/virtuser_name/${x}/" $FTP_VIRTUSER_CONF_DIR/$x
    mkdir -p $FTP_VIRTUSER_ROOT_DIR/$x
done

chown -R ftp.ftp /var/ftp
chown -R ftpvirtuser.ftpvirtuser $FTP_VIRTUSER_ROOT_DIR
