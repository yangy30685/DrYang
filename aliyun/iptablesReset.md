# Linux iptables 修改方法(Ubuntu or Centos)
by [yangspot.com](https://yangspot.com)

## 列出已设置的规则
>iptables -L [-t 表名] [链名]
>四个表名 raw，nat，filter，mangle
>五个规则链名 INPUT、OUTPUT、FORWARD、PREROUTING、POSTROUTING
>filter表包含INPUT、OUTPUT、FORWARD三个规则链

```sh
iptables -L -t nat # 列出 nat 上面的所有规则 -t 参数指定，必须是 raw， nat，filter，mangle 中的一个
iptables -L -t nat  --line-numbers  # 规则带编号
iptables -L -nv  # 查看，这个列表看起来更详细
iptables -L -n -v # 查看已添加的规则
```

## iptables command 
```sh
iptables -F  # 清空所有的防火墙规则
iptables -X  # 删除用户自定义的空链
iptables -Z  # 清空计数

iptables -F INPUT  # 清空指定链 INPUT 上面的所有规则
iptables -X INPUT  # 删除指定的链，这个链必须没有被其它任何规则引用，而且这条上必须没有任何规则。
iptables -Z INPUT  # 把指定链 input 所有计数器清零
```
## 配和指定表命令 -t raw/nat/filter/mangle 清空相应的表
```sh
iptables -t raw -F # 清空table raw 防火墙规则
iptables -t raw -X # 清空table raw 链
iptables -t raw -Z # 清空table raw package计数

iptables -t filter -F
iptables -t filter -X
iptables -t filter -Z

iptables -t nat -F 
iptables -t nat -X 
iptables -t nat -Z 

iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -Z

# reset the default policies in the filter table. 不指定 -t 默认就是filter table. 
# ACCEPT/DROP 允许和不允许：
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# reset the default policies in the raw table.
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT

# reset the default policies in the nat table.
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P INPUT ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# reset the default policies in the mangle table.
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P INPUT ACCEPT
iptables -t nat -P FORWARD ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

```
## 进出设置
```sh
iptables -A INPUT -i lo -j ACCEPT #lo 本地回环 就是那个127.0.0.1，是本机上使用的,它进与出都设置为允许
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -p all -s 192.168.1.0/24 -j ACCEPT  # 允许机房内网机器可以访问
iptables -A INPUT -p all -s 192.168.140.0/24 -j ACCEPT  # 允许机房内网机器可以访问
iptables -A INPUT -p tcp -s 183.121.3.7 --dport 3380 -j ACCEPT # 允许183.121.3.7访问本机的3380端口

iptables -A INPUT -p tcp --dport 80 -j ACCEPT # 开启80端口，因为web对外都是这个端口
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT # 允许被ping
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # 已经建立的连接得让它进来
```
## 添加 iptables 转发规则 
```sh
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j MASQUERADE 
iptables -t nat -A POSTROUTING -s 192.168.0.0/255.255.255.0 -j SNAT --to-source 47.254.45.119
iptables -t nat -A POSTROUTING -s 192.168.188.0/24 -j SNAT --to-source 47.254.45.119
```
[161.117.10.16](http://www.yangspot.com)为服务器地址
以上任意一个都行 不同的规则而已
>SNAT，DNAT，MASQUERADE都是NAT，MASQUERADE是SNAT的一个特例。
>SNAT是指在数据包从网卡发送出去的时候，把数据包中的源地址部分替换为指定的IP，<br>这样，接收方就认为数据包的来源是被替换的那个IP的主机；
>MASQUERADE是用发送数据的网卡上的IP来替换源IP，因此，对于那些IP不固定的场合，<br>比如拨号网络或者通过dhcp分配IP的情况下，就得用MASQUERADE；
>DNAT，就是指数据包从网卡发送出去的时候，修改数据包中的目的IP，表现为如果你想访问A，<br>可是因为网关做了DNAT，把所有访问A的数据包的目的IP全部修改为B，那么，你实际上访问的是B；
>因为，路由是按照目的地址来选择的，因此，DNAT是在PREROUTING链上来进行的，<br>而SNAT是在数据包发送出去的时候才进行，因此是在POSTROUTING链上进行的。

## Backup server start up setting
```sh
cp /etc/network/iptables.up.rules /etc/network/iptables.up.rules.backup
# save setting and echo to a file
iptables-save > /etc/network/iptables.up.rules
# list saved file successful
cat /etc/network/iptables.up.rules.backup
# restore start up setting from the file created above
iptables-restore < /etc/network/iptables.up.rules
# to enable startup autorun<br>Append following commond to /etc/network/interface file
pre-up iptables-restore < /etc/network/iptables.up.rules
``` 

## Block specific IP address
```sh
#add block IP
iptables -A INPUT -s IP_ADDRESS -j DROP
service iptables save

#delete block IP
iptables -D INPUT -s IP_ADDRESS -j DROP
service iptables save

``` 

[Back To Top](#)
