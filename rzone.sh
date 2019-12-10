#!/bin/bash
echo $$ >> /root/bindhelper.lock 
ZONE=$(dialog --title 'Remover Zona' --stdout --inputbox 'Digite o nome da zona: ' 0 0) 
[[ "$?" -ne "0" ]] && /etc/bindhelper/bindhelper2.sh
[[ -z "$ZONE" ]] && /etc/bindhelper/rzone.sh 
NUM=$(grep -n -m1 "$ZONE" /etc/bind/named.conf.local | cut -d : -f 1) 
EXI=$(grep -c $ZONE /etc/bind/named.conf.local) 
[[ "$EXI" == "0" ]] && dialog --msgbox 'Zona Inexistente' 0 0 && /etc/bindhelper/bindhelper2.sh
find / -name db.slave.$ZONE -print 2>/dev/null | grep slave >> /dev/null 
[[ "$?" == "1" ]] && TYPE="master" || TYPE="slave" 
if [ $TYPE = "master" ] 
then
	NUM2=$(echo "$NUM+3" | bc)
	sed -i ${NUM},${NUM2}d /etc/bind/named.conf.local 
else
	NUM2=$(echo "$NUM+4" | bc)
	sed -i ${NUM},${NUM2}d /etc/bind/named.conf.local 
fi 
[[ "$?" == "0" ]] && dialog --msgbox 'Zona Removida' 0 0 
dialog --yesno 'Deseja remover o arquivo db?' 0 0 && DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2) || /etc/bindhelper/bindhelper2.sh
[[ $TYPE == "slave" ]] && rm $DIR/db.slave.$ZONE || rm $DIR/db.$ZONE 
LIN=$(grep -n $ZONE dir.txt | cut -d : -f1) 
sed -i ${LIN}d /root/dir.txt 
dialog --msgbox 'Arquivo Deletado' 0 0
/etc/bindhelper/bindhelper2.sh
