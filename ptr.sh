#!/bin/bash
echo $$ >> /root/bindhelper.lock
ZONE=$1
OCT1=$(echo $ZONE | cut -d "." -f1)
OCT2=$(echo $ZONE | cut -d "." -f2)
OCT3=$(echo $ZONE | cut -d "." -f3)
if [ "$OCT1" = "$ZONE" ]; then
        ZONE=$OCT1
elif [ -z "$OCT3" ]; then
        ZONE=${OCT2}.${OCT1}
else
        ZONE=${OCT3}.${OCT2}.${OCT1}
fi
DIR=$(grep $ZONE /root/dir.txt | cut -d : -f2)
IP=$(dialog --stdout --inputbox "Digite os octetos de host" 0 0 "Ex: 0.0.1")
OCT1=$(echo $IP | cut -d "." -f1)
OCT2=$(echo $IP | cut -d "." -f2)
OCT3=$(echo $IP | cut -d "." -f3)
if [ "$OCT1" = "$IP" ]; then
        IP=$OCT1
elif [ -z "$OCT3" ]; then
        IP=${OCT2}.${OCT1}
else
        IP=${OCT3}.${OCT2}.${OCT1}
fi
REG=$(dialog --stdout --inputbox "Digite o registro a ser atrelado" 0 0)
ZONE2=$(dialog --stdout --inputbox "Digite a domínio do registro" 0 0 "exemplo.org")
echo "$IP	IN	PTR	$REG.$ZONE2." >> $DIR/db.$ZONE
service bind9 restart
/etc/bindhelper/menur.sh
