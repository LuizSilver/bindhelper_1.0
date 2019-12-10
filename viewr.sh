#!/bin/bash
echo $$ >> /root/bindhelper.lock
ZONE=$(dialog --stdout --inputbox "Digite o Domínio:" 0 0)
[[ $? -ne "0" ]] && /etc/bindhelper/menur.sh
DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2)
dialog --title 'arquivo db' --textbox $DIR/db.$ZONE 0 0
[[ $? -ne "0" ]] && dialog --msgbox 'Arquivo ou zona inexistente' 0 0 && /etc/bindhelper/menur.sh || /etc/bindhelper/menur.sh
