#/bin/bash
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

iptables-save > /etc/network/iptables.up.rules
iptables-save > /etc/network/iptables.up.rules.backup

service networking restart
service pptpd restart
echo "step1 finished"
echo
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j MASQUERADE 
iptables-save > /etc/network/iptables.up.rules
service networking restart
service pptpd restart
echo "step2 finished"
echo