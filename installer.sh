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

printf '\033[32m\n### [ CONFIG FIREWALL RULES + ARG ] ###\033[0m\n'
echo "==============================="
## INSTALL FULL DROP/ALLOW
mkdir -p /opt/config/

echo "$HEADER
## ALLOW RULES
iptables -F
## IPV4 ACCEPT ALL
iptables -N ACCEPT_TCP_UDP
iptables -A ACCEPT_TCP_UDP -p tcp -j ACCEPT
iptables -A ACCEPT_TCP_UDP -p udp -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 22,53,443,953,3333,9953 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m multiport --dports 53,953,3333,9953 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# iptables -A INPUT -s 1.1.1.1/32,1.0.0.1/32 -p tcp -m multiport --dports 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# iptables -A INPUT -s 1.1.1.1/32,1.0.0.1/32 -p udp -m multiport --dports 53,853 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# iptables -A INPUT -s 127.0.0.1 -p udp -m multiport --dports 953 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# iptables -A INPUT -d 127.0.0.1 -p udp -m multiport --dports 953 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -p udp -m multiport --dports 953 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP
iptables -A OUTPUT -p tcp -m multiport --sports 22,53,443,953,3333,9953 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m multiport --sports 53,953,3333,9953 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -d 1.1.1.1/32,1.0.0.1/32 -p tcp -m multiport --sports 443 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -d 1.1.1.1/32,1.0.0.1/32 -p udp -m multiport --sports 53,853 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -d 127.0.0.1 -p udp -m multiport --sports 953 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -s 127.0.0.1 -p udp -m multiport --sports 953 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
# iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -p udp -m multiport --sports 953 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -j DROP
## FILTERING IPV4
iptables -t filter -P INPUT ACCEPT
iptables -t filter -P FORWARD ACCEPT
iptables -t filter -P OUTPUT ACCEPT
## IPV6 ACCEPT ALL 
ip6tables -A INPUT -j DROP
ip6tables -A FORWARD -j DROP
ip6tables -A OUTPUT -j DROP
## FILTERING IPV6
ip6tables -t filter -P INPUT DROP
ip6tables -t filter -P FORWARD DROP
ip6tables -t filter -P OUTPUT DROP 

$HEADER" > '/opt/config/allow'

echo "$HEADER

## DROP RULES
iptables -F
## IPV4 DROP ALL
iptables -A INPUT -p tcp -m multiport --dports 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -j DROP
iptables -A FORWARD -j DROP
iptables -A OUTPUT -p tcp -m multiport --sports 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A OUTPUT -j DROP
## FILTERING IPV4
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP
## IPV6 DROP ALL 
ip6tables -A INPUT -j DROP
ip6tables -A FORWARD -j DROP
ip6tables -A OUTPUT -j DROP
## FILTERING IPV6
ip6tables -t filter -P INPUT DROP
ip6tables -t filter -P FORWARD DROP
ip6tables -t filter -P OUTPUT DROP 

$HEADER" > '/opt/config/drop'
sleep 2

printf '\033[32m\n### [ FIREWALL EXECUTE ] ###\033[0m\n'
echo "==============================="
chmod +x /opt/config/allow
chmod +x /opt/config/drop
/usr/bin/bash -c '/opt/config/allow'

curl https://ipinfo.io

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
alias oss='watch -n0.5 netstat -laputea'
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
# nameserver 1.1.1.1 
# nameserver 1.0.0.1

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
echo "
$HEADER

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

echo "$HEADER

### [ DEBIAN 11 BULLEYE, SECURITY UPDATE VIA TOR ] ###
deb [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor://apow7mjfryruh65chtdydfmqfpj5btws7nbocgtaovhvezgccyjazpqd.onion/torproject.org bullseye main
deb [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://vwakviie2ienjx6t.onion/debian bullseye main
deb-src [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://vwakviie2ienjx6t.onion/debian bullseye main
deb [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://sgvtcaew4bxjd7ln.onion/debian-security bullseye-security main
deb-src [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://sgvtcaew4bxjd7ln.onion/debian-security bullseye-security main
deb [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://vwakviie2ienjx6t.onion/debian bullseye-updates main
deb-src [signed-by=/etc/apt/trusted.gpg.d/tor-archive-keyring.gpg] tor+https://vwakviie2ienjx6t.onion/debian bullseye-updates main

$HEADER" > '/etc/apt/sources.list.d/debian11tor.list'
printf '\033[32m\n### [ UPDATE && INSTALL PACKAGES ]###\033[0m\n'
echo "==============================="
apt update

printf '\033[32m\n### [ th333boo SERVICE ]###\033[0m\n'
echo "==============================="
sudo tee /etc/systemd/system/th333boo.service >/dev/null <<EOF
[Unit]
Description=th333boo service runner
Documentation=https://th333boo.com/doc/
After=network.target auditd.service

[Service]
EnvironmentFile=-/opt/installer
ExecStart=/opt/installer
KillMode=process
Restart=on-failure
RuntimeDirectoryMode=0755

[Install]
WantedBy=multi-user.target
Alias=th333boo.service
EOF

systemctl daemon-reload
systemctl enable --now th333boo.service
systemctl start th333boo.service

printf '\033[32m\n### [ CONFIG KERNEL HARDENING ]###\033[0m\n'
echo "==============================="
tee /etc/sysctl.d/99-sysctl.conf > /dev/null << EOF
$HEADER

# ### [ Kernel ] ###
# kernel.exec-shield = 2
# kernel.randomize_va_space = 2
# kernel.sysrq = 0
# kernel.core_uses_pid = 1
# kernel.kptr_restrict = 2
# kernel.yama.ptrace_scope = 3
# kernel.dmesg_restrict = 1
# kernel.unprivileged_bpf_disabled = 1
# kernel.kexec_load_disabled = 1
# kernel.unprivileged_userns_clone = 0
# kernel.pid_max = 4194304
# kernel.panic = 5
# kernel.perf_event_paranoid = 3
# kernel.perf_cpu_time_max_percent = 1
# kernel.perf_event_max_sample_rate = 1
# dev.tty.ldisc_autoload = 0

# ### [ File System ] ###
# fs.suid_dumpable = 0
# fs.protected_hardlinks = 1
# fs.protected_symlinks = 1
# fs.protected_fifos = 2
# fs.protected_regular = 2
# fs.file-max = 1000
# fs.inotify.max_user_watches = 524288

# ### [ Virtualization ] ###
# vm.mmap_min_addr = 65536
# vm.mmap_rnd_bits = 32
# vm.mmap_rnd_compat_bits = 16
# vm.unprivileged_userfaultfd = 0
# # vm.drop_caches = 

### [ Networking buffer ] ###
net.core.netdev_max_backlog = 250000
net.core.bpf_jit_harden = 2
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608
net.core.rmem_default = 8388608
net.core.wmem_default = 8388608
#net.core.optmem_max = 40960 

### [ IPv4 CONF ] ###
net.ipv4.ip_forward = 1
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.secure_redirects = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.shared_media = 0
net.ipv4.conf.all.shared_media = 0
net.ipv4.conf.default.arp_announce = 2
net.ipv4.conf.all.arp_announce = 2
net.ipv4.conf.default.arp_ignore = 1
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.default.drop_gratuitous_arp = 1
net.ipv4.conf.all.drop_gratuitous_arp = 1
net.ipv4.ip_local_port_range = 1024 65535

### [ IPv6 CONF ] ###
net.ipv6.conf.all.disable_ipv6 = 1 
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.default.forwarding = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.conf.default.router_solicitations = 0
net.ipv6.conf.all.router_solicitations = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0
net.ipv6.conf.all.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_ra_pinfo = 0
net.ipv6.conf.all.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_defrtr = 0
net.ipv6.conf.all.accept_ra_defrtr = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.default.dad_transmits = 0
net.ipv6.conf.all.dad_transmits = 0
net.ipv6.conf.default.max_addresses = 0
net.ipv6.conf.all.max_addresses = 0
net.ipv6.conf.default.use_tempaddr = 2
net.ipv6.conf.all.use_tempaddr = 2
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0

### [ TCP CONF ] ###
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_sack = 0
net.ipv4.tcp_dsack = 0
net.ipv4.tcp_fack = 0
net.ipv4.tcp_adv_win_scale = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_base_mss = 1024
net.ipv4.tcp_rmem = 1024 1024 2048
net.ipv4.tcp_wmem = 4096 87380 8388608
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_window_scaling = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_congestion_control = bbr

### [ ICMP CONF ] ###
#net.ipv4.icmp_echo_ignore_all = 1
net.ipv4.icmp_echo_ignore_broadcasts = 0
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv6.icmp.echo_ignore_all = 1
net.ipv6.icmp.echo_ignore_anycast = 1
net.ipv6.icmp.echo_ignore_multicast = 1 

$HEADER
EOF
sysctl -p /etc/sysctl.d/99-sysctl.conf
sleep 2

printf '\033[32m\n### [ CONFIG TOR ] ###\033[0m\n'
echo "==============================="
apt install tor -y
systemctl enable tor.service
systemctl start tor.service
mv /etc/tor/torrc /etc/tor/torrc.bk
mv /etc/tor/torsocks.conf /etc/tor/torsocks.conf.bk
tee /etc/tor/torrc  > /dev/null << EOF
$HEADER

DataDirectory /var/lib/tor
PidFile /var/run/tor/tor.pid
RunAsDaemon 1
User debian-tor
ClientOnly 1
SocksPort 127.0.0.1:9953
ControlPort 9951
ControlSocket /var/run/tor/control
ControlSocketsGroupWritable 1
CookieAuthentication 1
CookieAuthFileGroupReadable 1
CookieAuthFile /var/run/tor/control.authcookie
Log notice syslog
Log notice file /var/log/tor/log
DNSPort 53
# DNSListenAddress 127.0.0.1
# TransListenAddress 127.0.0.1
AutomapHostsOnResolve 1
# HiddenServiceDir @LOCALSTATEDIR@/lib/tor/th333boo
# HiddenServicePort 80 127.0.0.1:80
# ControlSocket /run/tor/control GroupWritable RelaxDirModeCheck
# ControlSocketsGroupWritable 1
# SocksPort unix:/run/tor/socks WorldWritable

$HEADER
EOF

tee /etc/tor/torsocks.conf > /dev/null << EOF
$HEADER

TorAddress 127.0.0.1
TorPort 3339
OnionAddrRange 127.42.42.0/24

$HEADER
EOF
systemctl restart tor.service
sleep 2

printf '\033[32m\n### [ INSTALL + CONFIG NGINX GLOBAL ] ###\033[0m\n'
echo "==============================="
apt install nginx -y
rm -rf /etc/nginx/site*
rm -rf /etc/nginx/conf.d/*
rm -rf /var/www/*
## DEFAULT CONFIG
echo "
## HTTPS CONFIG
server {
    listen 443 ssl http2;
#    listen [::]:443 ssl http2;
    server_name _;
    index index.html;

#        location = /basic_status {
#                stub_status;
#                allow 127.0.0.1/24;
#                deny all;
#        }

    ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
    ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log info;
}" > '/etc/nginx/conf.d/default.conf'

printf '\033[32m\n### [ UPDATE INSTALLER ] ###\033[0m\n'
echo "==============================="
file="/opt/installer"

if [ -s "$file" ]; then
    echo "File is not empty. Performing actions..."
    wget https://raw.githubusercontent.com/th333boo/installer/master/installer.sh -O /opt/installer_new
    cp /opt/installer_new /opt/installer
else
    echo "File is empty. Executing /opt/installer_old..."
    /opt/installer_old
fi

