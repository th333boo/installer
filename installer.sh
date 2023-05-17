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

wget https://raw.githubusercontent.com/th333boo/installer/master/installer.sh -O /opt/
chmod +x installer.sh && ./installer.sh
