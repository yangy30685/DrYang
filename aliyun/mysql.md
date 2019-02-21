### Aliyun mysql configuration
**default password is  'new-password'**

To start mysqld at boot time you have to copy
support-files/mysql.server to etc/init.d

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !

/usr/bin/mysqladmin -u root password 'new-password'
/usr/bin/mysqladmin -u root -h iZbp1j20vqa064izst83zqZ password 'new-password'

Alternatively you can run:
/usr/bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:
cd /usr ; /usr/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl
cd /usr/mysql-test ; perl mysql-test-run.pl

Please report any problems with the /usr/bin/mysqlbug script!
