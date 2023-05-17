#!/bin/bash
HEADER="
### ### ### ### ### ### ### ### ###
###         th333boo            ###
### telegram: @th333boo         ###
### www: https://th333boo.com   ###
### mail: contact@th333boo.com  ###
###     all right reserved      ###
### ### ### ### ### ### ### ### ###"

printf '\033[32m\nBANNER \033[0m\n'
echo "==============================="
> /etc/motd 
cat $HEADER > '/etc/motd'