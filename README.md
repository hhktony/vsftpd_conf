step 0: Some changes
=======

0. Install the relevant software

* CentOS

    # yum install -y vsftpd db4*

* Ubuntn

    # sudo apt-get install -y vsftpd db4* 

1. Backup your configure file

* CentOS

    # cp -r /etc/vsftpd/ /etc/vsftpd.`date +%F`.bak
    # cp -r /etc/pam.d/vsftpd /etc/pam.d/vsftpd.`date +%F`.bak

* Ubuntn

    # cp /etc/vsftpd.conf /etc/vsftpd.conf.`date +%F`.bak
    # cp -r /etc/pam.d/vsftpd /etc/pam.d/vsftpd.`date +%F`.bak

2. Add virtual users

    # vim vusers

* Instructions: 

```
The odd number line is user name,

The even number line is user name.

End with .r is read only

End with .r_w is read only

The virtual user name must end with `.r` or `.r_w`
```


step 1: Install configure 
=======

Execute the script
    
    # chmod +x create_vsftpd_conf.sh
    # ./create_vsftpd_conf.sh

step 2: PS
=======

* If you want add some virtual user, step following

1.  Add user

    # vim /etc/vusers # Refer to the `step0 2(Add virtual users)`

2. Generates the database files

    # db_load -T -t hash -f /etc/vsftpd/vusers /etc/vsftpd/vusers.db

3. Generates the configure files

    # cp /etc/vsftpd/vusers_conf/vusers_conf.x /etc/vsftpd/vusers_conf/username # x depend on permissions

4. Create user's root directory

    # mkdir /var/ftpvuser/usrename

5. Change belongs to who

    # chown -R ftpvuser.ftpvuser /var/ftpvuser/

* Instructions

```
Relevant documents according to the configuration of a file
```
