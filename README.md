### Some changes

1. Install the relevant software

    yum install -y vsftpd db4*

2. Backup your configure file

    cp -r /etc/vsftpd/ /etc/vsftpd.\`date +%F\`.bak
    
    cp -r /etc/pam.d/vsftpd /etc/pam.d/vsftpd.\`date +%F\`.bak

3. Add virtual users, additional username and password

    vim vusers

Instructions:

```
The odd number line is user name,

The even number line is user name.

End with .r is read only

End with .r_w is read only

The virtual user name must end with .r or .r_w

eg:
    test.r
    test
```


### Install configure

Execute the script

    chmod +x update.sh
    ./update.sh

### PS

If you want add some virtual user, step following

1.  Add user(Refer to the Add virtual users)

    vim /etc/vusers

2. Produce relevant documents

    ./update.sh adduser

Instructions

```
Relevant documents according to the configuration of a file
```

## FAQ

If some settings and do not understand, see `vsftpd.conf`
