#!/bin/bash
HEADER="### ### ### ### ### ###
### Managed by BBI WEBSEC ###
### ### ### ### ### ###"

printf '\033[32m\n### [ CONFIG UX WELCOME PAGE ] ### \033[0m\n'
echo "==============================="
rm -f /etc/motd
rm -f /etc/issue.net
echo "$HEADER

### [ th333boo ] ###  
telegram: @th333boo         
www: https://th333boo.com   
mail: contact@th333boo.com  
all right reserved

$HEADER" > '/etc/motd'
cat /etc/motd
sleep 2

printf '\033[32m\n### [ NETWORK CARD SETUP ]###\033[0m\n'
echo "==============================="

echo "$HEADER

auto lo
iface lo inet loopback
    dns-nameservers 127.0.0.1
    dns-search invalid

$HEADER" > '/etc/network/interfaces.d/lo'
/etc/init.d/networking restart

printf '\033[32m\nCONFIG DNS RESOLVER  \033[0m\n'
echo "==============================="
mv /etc/resolv.conf /etc/resolv.conf.bk
echo "$HEADER

nameserver 127.0.0.1
nameserver 1.1.1.1 
nameserver 1.0.0.1

$HEADER" > '/etc/resolv.conf.new'
sleep 2
cp /etc/resolv.conf.new /etc/resolv.conf
cat /etc/resolv.conf
echo "$HEADER

[Resolve]
DNS = 127.0.0.1
DNS= 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
FallbackDNS=127.0.0.1
#Domains=
DNSSEC=yes
DNSOverTLS=yes
#MulticastDNS=yes
#LLMNR=yes
#Cache=yes
#DNSStubListener=yes
#DNSStubListenerExtra=
#ReadEtcHosts=yes
#ResolveUnicastSingleLabel=no

$HEADER" > '/etc/systemd/resolved.conf'

printf '\033[32m\nUPDATE INSTALLER  \033[0m\n'
echo "==============================="
rm installer*
wget https://raw.githubusercontent.com/th333boo/installer/master/installer -O /opt/installer
chmod +x installer && ./installer
