#!/bin/bash
echo $$ >> /root/bindhelper.lock
cancel(){  [[ $? -ne "0" ]] && /etc/bindhelper/menur.sh ;};
TYPE=$(dialog --title "Criar Registro" --stdout --menu "Selecione o registro:" 0 0 0 "A" '' "CNAME" '' "MX" '' "PTR" '')
cancel
ZONE=$(dialog --stdout --inputbox "Digite o Domínio:" 0 0)
cancel
while [[ -z $ZONE ]]
do
	ZONE=$(dialog --stdout --inputbox "Digite o Domínio:" 0 0)
	cancel
done
[[ $TYPE == "A" ]] && NAME=$(dialog --stdout --inputbox "Digite o nome do registro:" 0 0) && IP=$(dialog --stdout --inputbox "Digite o IP:" 0 0) && DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2) && echo "$NAME	IN	$TYPE	$IP" >> $DIR/db.$ZONE && service bind9 restart
[[ $TYPE == "CNAME" ]] && NAME=$(dialog --stdout --inputbox "Digite o nome do registro:" 0 0) && REG=$(dialog --stdout --inputbox "Digite o registro a ser apontado:" 0 0) && DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2) && echo "$NAME	IN	$TYPE	$REG.$ZONE." >> $DIR/db.$ZONE && service bind9 restart
[[ $TYPE == "MX" ]] && PRIO=$(dialog --stdout --inputbox "Digite a prioridade:" 0 0) && REG=$(dialog --stdout --inputbox "Digite o registro a ser apontado:" 0 0) && DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2) && echo "@	IN	$TYPE $PRIO	$REG.$ZONE." >> $DIR/db.$ZONE && service bind9 restart
[[ $TYPE == "PTR" ]] && /etc/bindhelper/ptr.sh $ZONE
/etc/bindhelper/menur.sh
