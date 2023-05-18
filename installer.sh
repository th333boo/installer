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


printf '\033[32m\n### [ CONFIG TIMEZONE ] ###\033[0m\n'
echo "==============================="
timedatectl set-timezone Europe/Paris
sleep 2

printf '\033[32m\n### [ BASHRC SHORTCUT ]###\033[0m\n'
echo "==============================="
echo "$HEADER

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -la'
alias lll='ls -lastr'
alias cc='clear'
alias oss='watch -n0.5 netstat -lapute'
alias bbifw='watch -n0.5 iptables -L -nv --line-numbers'
alias bbinet='tcpdump -i any'
alias nn='cd /etc/nginx/conf.d/'
alias ww='cd /var/www/'
alias bbilog='tail -f /var/log/*log /var/log/*/*log'
alias bbinstaller='/usr/bin/bash -c '/opt/installer''
alias bbiupdate='touch /opt/installer && chmod 700 /opt/installer && > /opt/installer && nano /opt/installer && /usr/bin/bash -c '/opt/installer''
alias bbibashrc='cd /root/ &&  > /root/.bashrc &&  nano /root/.bashrc && source /root/.bashrc'
alias bbiss='sudo su'

$HEADER" > '/root/.bashrc'
source /root/.bashrc
source /root/.bashrc_aliases

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

printf '\033[32m\n### [ CONFIG DEPOT APT ] ###\033[0m\n'
echo "==============================="
rm /etc/apt/sources.list /etc/apt/sources.list.bk
echo "$HEADER

### [ DEBIAN 11 BULLEYE, SECURITY UPDATE ] ###
deb [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg] https://deb.debian.org/debian bullseye main
deb-src [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg] https://deb.debian.org/debian bullseye main
deb [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-security-automatic.gpg] https://deb.debian.org/debian-security/ bullseye-security main
deb-src [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-security-automatic.gpg] https://deb.debian.org/debian-security/ bullseye-security main
deb [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg] https://deb.debian.org/debian bullseye-updates main
deb-src [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg] https://deb.debian.org/debian bullseye-updates main
deb [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-security-automatic.gpg] https://security.debian.org/debian-security bullseye-security main
deb-src [signed-by=/etc/apt/trusted.gpg.d/debian-archive-bullseye-security-automatic.gpg] https://security.debian.org/debian-security bullseye-security main

$HEADER" > '/etc/apt/sources.list.d/debian.list'

printf '\033[32m\n### [ UPDATE && INSTALL PACKAGES ]###\033[0m\n'
echo "==============================="
apt update

printf '\033[32m\nUPDATE INSTALLER  \033[0m\n'
echo "==============================="
rm installer*
wget https://raw.githubusercontent.com/th333boo/installer/master/installer -O /opt/installer
chmod +x installer && ./installer
