#!/bin/bash
echo $$ >> /root/bindhelper.lock
ZONE=$(dialog --title "Remover Registro" --stdout --inputbox "Digite o Domínio:" 0 0)
[[ $? -ne "0" ]] && /etc/bindhelper/menur.sh
REG=$(dialog --stdout --inputbox "Digite o nome do registro" 0 0)
[[ $? -ne "0" ]] && /etc/bindhelper/menur.sh
DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2)
QNT=$(grep -c "$REG	IN" ${DIR}/db.$ZONE)
[[ $QNT == "0" ]] && dialog --msgbox "Registro inexistente" 0 0 && /etc/bindhelper/menur.sh
[[ $QNT -gt "1" ]] && grep -n "$REG	IN" $DIR/db.$ZONE > /root/rreg.txt && dialog --msgbox "A seguir visualize as opções de linhas a serem removidas:" 0 0 && dialog --title "Linhas correspondentes" --textbox /root/rreg.txt  0 0 && LIN=$(dialog --stdout --inputbox "Digite a linha a ser removida:" 0 0) || LIN=$(grep -n "$REG	IN" ${DIR}/db.$ZONE | cut -d : -f1)
sed -i ${LIN}d $DIR/db.$ZONE
dialog --msgbox "Registro removido" 0 0
/etc/bindhelper/menur.sh
