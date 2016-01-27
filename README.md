### Some changes

1. Install the relevant software

    yum install -y vsftpd lftp ftp libdb-utils

2. Backup your configure file

    cp -r /etc/vsftpd/ /etc/vsftpd.\`date +%F\`.bak
    cp -r /etc/pam.d/vsftpd /etc/pam.d/vsftpd.\`date +%F\`.bak

Instructions:

```
The odd number line is user name,

The even number line is user password.

End with .r is read only

End with .r_w is read only

The virtual user name must end with .r or .r_w

eg:
    test.r
    test

```

### Install configure

Execute the script

    chmod +x vsftpd-ctl.sh
    ./vsftpd-ctl.sh --init

### Adduser

    ./vsftpd-ctl.sh --useradd username passwd rw

Instructions

```
Relevant documents according to the configuration of a file
```

## FAQ

If some settings and do not understand, see `vsftpd.conf`
