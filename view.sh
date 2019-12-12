#!/bin/bash
echo $$ >> /root/bindhelper.lock 
dialog --title 'named.conf.local' --textbox /etc/bind/named.conf.local 0 0
[[ $? == "0" ]] && /etc/bindhelper/bindhelper2.sh
