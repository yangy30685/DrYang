# Linux (Centos 7 or Ubuntu)configure LNMP
# 1 Install epel-release

>sudo yum install epel-release

# 2 Install MySQL

>sudo yum install mysql-server

Once the download is complete, restart MySQL:

>sudo /etc/init.d/mysqld restart
You can do some configuration of MySQL with this command:

>sudo /usr/bin/mysql_secure_installation
The prompt will ask you for your current root password.

Remove anonymous users? [Y/n] y                                            
...Success!

# 3 Install nginx

As with MySQL, we will install nginx on our virtual private server using yum:

>sudo yum install nginx

nginx does not start on its own. To get nginx running, type:

>sudo /etc/init.d/nginx start

You can confirm that nginx has installed on your virtual private server by directing your browser to your IP address.
You can run the following command to reveal your server’s IP address.
>ifconfig eth0 | grep inet | awk '{ print $2 }'

# 4 Install PHP

>sudo yum install php-fpm php-mysql

# 5 Configure php
We need to make one small change in the php configuration. Open up php.ini:

>sudo vi /etc/php.ini
Find the line, cgi.fix_pathinfo=1, and change the 1 to 0.

>cgi.fix_pathinfo=0

If this number is kept as a 1, the php interpreter will do its best to process the file that is as near to the requested file as possible. This is a possible security risk. If this number is set to 0, conversely, the interpreter will only process the exact file path—a much safer alternative. Save and Exit.

# 6 Configure nginx
Open up the default nginx config file:

>sudo vi /etc/nginx/nginx.conf
Raise the number of worker processes to 4 then save and exit that file.
This is not necessary!

>sudo vi /etc/nginx/conf.d/default.conf
The configuration should include the changes below (the details of the changes are under the config information):

```sh
# The default server

server {
    listen       80;
    server_name example.com;

   
    location / {
        root   /usr/share/nginx/html;
        index index.php  index.html index.htm;
    }

    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/html;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    location ~ \.php$ {
        root           /usr/share/nginx/html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME   $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}
```

Open up the php-fpm configuration:

>sudo vi /etc/php-fpm.d/www.conf
### Replace the apache in the user and group with nginx:
```sh
; Unix user/group of processes
; Note: The user is mandatory. If the group is not set, the default users group
;	will be used.
; RPM: apache Choosed to be able to access some dir as httpd
user = nginx
; RPM: Keep a group allowed to write in log dir.
group = nginx
```
Finish by restarting php-fpm.

>sudo service php-fpm restart

# 7 RESULTS: Create a php info page

>sudo vi /usr/share/nginx/html/info.php
Add in the following line:
```php
<?php
phpinfo();
?>
```
Then Save and Exit.<br>
Restart nginx so that all of the changes take effect:

>sudo service nginx restart
Finish up by visiting your php info page (make sure you replace the example ip address with your correct one): http://47.89.244.27/info.php

Step Eight—Set Up Autostart

You are almost done. The last step is to set all of the newly installed programs to automatically begin when the VPS boots.

>sudo chkconfig --levels 235 mysqld on<br>
>sudo chkconfig --levels 235 nginx on<br>
>sudo chkconfig --levels 235 php-fpm on<br>
>sudo chkconfig --levels 235 php-fpm on<br>

