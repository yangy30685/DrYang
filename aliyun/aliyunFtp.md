# OS-Ubunut 14.04 configure FTP server
by [yangspot.com](http://yangspot.com)
# pre-requisite server configuration
>active mode： open port 20/21<br>
>passive mode: open port >1024. For instance 60000/60500 the gap is greater than 100
>su -root
### 1. 安装软件 vsftpd 在服务器端
```
  apt install vsftpd
```
### 2.  安装完以后 找到配置文件 
ubuntu和centos的位置不一样,名字可能有区别 找找名字带有vsftpd或者conf的文件
```
  cat /etc/vsftpd.conf
```
centos可能在这个路径里面/etc/vsftpd/vsftpd.conf
修改前备份一个 用来救急
```
  cp /etc/vsftpd.conf /etc/vsftpd.conf.back
```

### 3. 修改配置文件vsftpd.conf **这个很麻烦 需要多次调试**
配置文件中的`=`号两边不要有空格,YES和NO要大写
如果连接的时候报错 试着先修改
```
  pam_service_name=vsftpd
```
这条语句为
```
  pam_service_name=ftp
```
这个设置需要尝试几次

匿名访问设置
```sh
  anonymous_enable=NO
```
这里选择的NO 配置成功后自行修改

如果改为YES 需要更改这些设置
```sh
  anon_upload_enable=YES
  anon_mkdir_write_enable=YES
```
这些默认都是NO
匿名用户的主文件夹应该在
```sh
  cd /src/ftp
```
确认有就行了 推荐就用这个路径 这个是匿名用户登录的主文件夹 一般用不到 因为安全原因这里不允许匿名登录

允许用户本地登录
```sh
  local_enable=YES
```
这里选YES 等会儿要用来验证配置是否正确 可以用来排除网络配置的影响

禁止全局写命令 修改为yes才能上传文件
```sh
  write_enable=YES
```
允许主动模式使用port 20 作为数据传输 这样服务器只要开20和21端口
```sh
  connect_from_port_20=YES
```
### 4. 权限配置 这个容易出错 本案例的配置如下
配置权限让用户**本地**和**远程** 登录后 都只能看见自己的主文件夹 
```sh
  chroot_local_user=YES
  chroot_list_enable=NO
  chroot_list_file=/etc/vsftpd.chroot_list
```
后面会详细解说这个组合
需要自己手动创建文件vsftpd.chroot_list
```sh
  touch /etc/vsftpd.chroot_list
  chmod 777 /etc/vsftpd.chroot_list
```
验证配置成功后再降低这个文件的权限

list里面添加需要限制的用户 一行一个，这里是名为ftp123的用户可以登录并且被限制 如何该用户添加了限制 上传服务也同时disable了
```sh
  ftp123
  anonymous
```
如果设置了anonymous，就添加anonymous让匿名用户登录

推荐添加一个非root用户 如ftp123 用来使用ftp服务 如下
```sh
   useradd -d /home/ftp123 -s /bin/bash ftp123
```   
这里 -d 指定主文件位置 -s 指定shell为bash 该用户可以远程登录

建议使用如下命令限制用户ftp123的远程登录为ftp only 
  usermod -s /usr/sbin/nologin ftp123 
路径也可能是 /sbin/nologin/
<br>
可以用 
```sh
  find / -name nologin
```
查找一下位置

因为ftp123是被限制用户 不能上传文件 这里的ftp123文件夹如果属于ftp123用户，权限不能有写，因此设为666 
```sh
 chmod 666 /home/ftp123
```
为新建的用户设置密码 
```sh
  passwd ftp123
```
然后按照提示输入密码 用
```sh
  cat etc/passwd
```
可以查看添加用户是否成功

配置完成后使用
```sh
service vsftpd restart
```
重启服务 也可能是这个命令
```sh
systemctl restart vsftpd.service
```
**以上配置不对连接是都会有错误 需要重复排查多次**

### 重点说明一下权限配置组合
***
单独设置chroot_local_user=YES后两条comment如下
```sh
  chroot_local_user=YES
  #chroot_list_enable=NO
  #chroot_list_file=/etc/vsftpd.chroot_list
```
则把所有本地用户都限制在自己的根路径
如果改为NO
```sh
  chroot_local_user=NO
  #chroot_list_enable=NO
  #chroot_list_file=/etc/vsftpd.chroot_list
```
则把所有本地用户都不限制 单独设置时用户可以上传文件 文件夹可以有写权限

如果需要指定限制用户需要组合如下语句 组合设置需要修改文件夹属性 不能写 list 用户都不能上传
```sh
  chroot_local_user=NO
  chroot_list_enable=YES
  chroot_list_file=/etc/vsftpd.chroot_list
```
组合设置时 chroot_local_user=NO这句话的意思发生了变异 这里先设置NO且enble为YES 
list里面的用户被限制在自己的根文件夹 

>如果改为
```sh
  chroot_local_user=YES
  chroot_list_enable=YES
  chroot_list_file=/etc/vsftpd.chroot_list
```
>list的用户是不被限制在自己的根目录 
>其他组合可以自己多尝试！
**

### 5. 验证配置设置
>验证配置是否正确 在本地使用
```sh
ftp localhost
```
然后使用ftp123 登录 不要用root
提示230 login successful表示配置成功
然后使用
```sh
  cd ..
  ls -al
```
不跳转其他路径 说明限制成功

### 6. 客户端连接说明 
这里用的filezilla 在windows 10 上登录的服务器 选择的是active 模式！<br>
因此本地防火墙需要filezilla程序使用所有端口<br>
并且本地路由器打开了一组高位端口 60000/60100可以自己调节 间隔最好大于100<br>

### 7. 如果还有问题可参见这个
#### [详细的vsftpd 配置解释](http://vsftpd.beasts.org/vsftpd_conf.html)
可能出现错误的地方:
***
- 主动访问和被动访问方式
- 服务器安全组开放的端口 
- 被动模式:客户端上网的路由器防火墙打开高位端口 例如1024/60000
- 主动模式:客户端路由服务uptp要关闭

*附一个配置样板*
```sh
# Example config file /etc/vsftpd.conf
#
# The default compiled in settings are fairly paranoid. This sample file
# loosens things up a bit, to make the ftp daemon more usable.
# Please see vsftpd.conf.5 for all compiled in defaults.
#
# READ THIS: This example file is NOT an exhaustive list of vsftpd options.
# Please read the vsftpd.conf.5 manual page to get a full idea of vsftpd's
# capabilities.
#
#
# Run standalone?  vsftpd can run either from an inetd or as a standalone
# daemon started from an initscript.
listen=YES
#
# Run standalone with IPv6?
# Like the listen parameter, except vsftpd will listen on an IPv6 socket
# instead of an IPv4 one. This parameter and the listen parameter are mutually
# exclusive.
#listen_ipv6=YES
#
# Allow anonymous FTP? (Disabled by default)
anonymous_enable=NO
#
# Uncomment this to allow local users to log in.
local_enable=YES
#
# Uncomment this to enable any form of FTP write command.
write_enable=YES
#
# Default umask for local users is 077. You may wish to change this to 022,
# if your users expect that (022 is used by most other ftpd's)
local_umask=022
#
# Uncomment this to allow the anonymous FTP user to upload files. This only
# has an effect if the above global write enable is activated. Also, you will
# obviously need to create a directory writable by the FTP user.
#anon_upload_enable=YES
#
# Uncomment this if you want the anonymous FTP user to be able to create
# new directories.
#anon_mkdir_write_enable=YES
#
# Activate directory messages - messages given to remote users when they
# go into a certain directory.
dirmessage_enable=YES
#
# If enabled, vsftpd will display directory listings with the time
# in  your  local  time  zone.  The default is to display GMT. The
# times returned by the MDTM FTP command are also affected by this
# option.
use_localtime=YES
#
# Activate logging of uploads/downloads.
xferlog_enable=YES
#
# Make sure PORT transfer connections originate from port 20 (ftp-data).
connect_from_port_20=YES
#
# If you want, you can arrange for uploaded anonymous files to be owned by
# a different user. Note! Using "root" for uploaded files is not
# recommended!
#chown_uploads=YES
#chown_username=whoever
#
# You may override where the log file goes if you like. The default is shown
# below.
#xferlog_file=/var/log/vsftpd.log
#
# If you want, you can have your log file in standard ftpd xferlog format.
# Note that the default log file location is /var/log/xferlog in this case.
#xferlog_std_format=YES
#
# You may change the default value for timing out an idle session.
#idle_session_timeout=600
#
# You may change the default value for timing out a data connection.
#data_connection_timeout=120
#
# It is recommended that you define on your system a unique user which the
# ftp server can use as a totally isolated and unprivileged user.
#nopriv_user=ftpsecure
#
# Enable this and the server will recognise asynchronous ABOR requests. Not
# recommended for security (the code is non-trivial). Not enabling it,
# however, may confuse older FTP clients.
#async_abor_enable=YES
#
# By default the server will pretend to allow ASCII mode but in fact ignore
# the request. Turn on the below options to have the server actually do ASCII
# mangling on files when in ASCII mode.
# Beware that on some FTP servers, ASCII support allows a denial of service
# attack (DoS) via the command "SIZE /big/file" in ASCII mode. vsftpd
# predicted this attack and has always been safe, reporting the size of the
# raw file.
# ASCII mangling is a horrible feature of the protocol.
#ascii_upload_enable=YES
#ascii_download_enable=YES
#
# You may fully customise the login banner string:
#ftpd_banner=Welcome to blah FTP service.
#
# You may specify a file of disallowed anonymous e-mail addresses. Apparently
# useful for combatting certain DoS attacks.
#deny_email_enable=YES
# (default follows)
#banned_email_file=/etc/vsftpd.banned_emails
#
# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
chroot_local_user=NO
#
# You may specify an explicit list of local users to chroot() to their home
# directory. If chroot_local_user is YES, then this list becomes a list of
# users to NOT chroot().
# (Warning! chroot'ing can be very dangerous. If using chroot, make sure that
# the user does not have write access to the top level directory within the
# chroot)
#chroot_local_user=YES
chroot_list_enable=YES
# (default follows)
chroot_list_file=/etc/vsftpd.chroot_list
#
# You may activate the "-R" option to the builtin ls. This is disabled by
# default to avoid remote users being able to cause excessive I/O on large
# sites. However, some broken FTP clients such as "ncftp" and "mirror" assume
# the presence of the "-R" option, so there is a strong case for enabling it.
#ls_recurse_enable=YES
#
# Customization
#
# Some of vsftpd's settings don't fit the filesystem layout by
# default.
#
# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
secure_chroot_dir=/var/run/vsftpd/empty
#
# This string is the name of the PAM service vsftpd will use.
#pam_service_name=vsftpd
pam_service_name=ftp
#
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
# This option specifies the location of the RSA key to use for SSL
# encrypted connections.
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```
[Back To Top](#)
