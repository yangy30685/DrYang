# OS ubunut14.04 Configure vpn
by [yangspot.com](http://yangspot.com)
### 1. 配置 PPTP server 需要使用的端口 Tcp 1723 
>一定要在安全组中放行`TCP 1723`端口 

### 2. 安装 PPTP 服务端
>使用命令 apt install -y ppp pptpd 安装软件
  
### 3. 修改配置文件 vim /etc/pptpd.conf 编辑配置文件
>去掉下面两行前面的#号
    #localip 192.168.0.1
    #remoteip 192.168.0.234-238
>CentOS 6.0 和 ubuntu 14.04的配置文件名字是一样的

### 4. 运行 vim /etc/ppp/options-pptpd 将 ms-dns 修改为 223.5.5.5 和 223.6.6.6 保存后退出
>去掉下面两行的#号
    #ms-dns 10.0.0.1
    #ms-dns 10.0.0.2
>并且修改为：
    ms-dns 223.5.5.5
    ms-dns 223.5.5.5
>建议就用这个阿里的DNS 不要用Google的 

### 5. 运行 vim /etc/ppp/chap-secrets 
>设置 pptpd 的用户名和密码。根据需要添加账号，一行只添加一个用户账号。按照 用户名 pptpd 密码 IP地址 的格式输入，每一项用空格隔开。
>保存后退出。示例：test pptpd 123456 *，其中 * 表示所有IP。
```sh
    # Secrets for authentication using CHAP
    # client server secret IP addresses
    Yang pptpd 123456 *
    Sam  pptpd 654321 *
```

### 6. 运行 vi /etc/ppp/ip-up 设置最大传输单元 MTU.
>官方指南说的是在 
>[ -x /etc/ppp/ip-up.local ] && /etc/ppp/ip-up.local “$@” 
>后面添加 ifconfig ppp0 mtu 1472。

这句命令可能变成这样的了
```sh
    if [ -x /etc/ppp/ip-up.local ]；then
    /etc/ppp/ip-up.local “$@”； 
    fi 
    ifconfig ppp0 mtu 1472 # 就在fi后面加就行了
```
 
### 7. 运行 vi /etc/sysctl.conf 编辑配置文件
>修改 net.ipv4.ip_forward = 1 保存后退出
>运行 systcl -p 检查生效

 ### 8. 配置iptables 一般问题都出在这！
>运行 iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j MASQUERADE 
>添加的是 MASQUERADE 转发规则
>或者运行 iptables -t nat -A POSTROUTING -s 192.168.0.0/255.255.255.0 -j SNAT --to-source 47.254.45.119 
>添加的是 SNAT 转发规则，其中 47.254.45.119 替换为你的的服务器公网 IP 地址
>运行 iptables-save 保存设置

`这步骤很关键！不要使用eth0或者eth1设置`<br>`很多教程都纠结专有网络和经典网络; 阿里云到底有没有vpn服务; 还有内外网卡等问题！`<br>`尽量先别纠结这些问题 按这个教程先走一遍 能打通pptpd就说明可以了，不能再去找其他资源解决以上问题。`<br>`先不要设置复杂的iptables配置 容易出错！实在有问题就purge iptables 或者 重置系统(方法如下)`<br>`如果自己用 没有重要数据 尽量简化设置 除非特别明白`

[重置 iptables 的方法](https://github.com/yangy30685/drYangSpot/blob/master/iptables_reset.sh)

### 9. 运行 systemctl restart pptpd 重启 PPTP 服务。
>如果systemctl提示找不到命令 可以用service命令 或者 直接进入`/etc/init.d` 运行可执行文件pptpd
```sh
    cd /etc/init.d/ 
    ./pptpd restart
```
>开机自动运行pptpd.service 和 iptables 这里没有设置避免错误

### 10. 至此，PPTP VPN 服务端安装结束了。
>可以在 Windows 客户端的 网络和共享中心 设置新的连接或网络，即可通过 VPN 访问网络<br>
>iphone产品现在用不了pptpd服务<br>
>用户名和密码就是之前的<br>
```
    Yang  123456 
    Sam   654321 
```
>任意一个就行
>用ifconfig查看一下网卡 如果有ppp0就是成功了

[Back To Top](#)
