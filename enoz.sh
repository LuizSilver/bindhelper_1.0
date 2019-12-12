#!/bin/bash
echo $$ >> /root/bindhelper.lock 
DIR=/etc/bind 
IP=$(dialog --title 'Criar Zona' --stdout --inputbox 'Digite os octetos de rede:' 0 0 "Ex: 192.168.0") 
if [ "$?" -ne "0" ]
    then
            /etc/bindhelper/bindhelper2.sh
    fi 
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
grep $IP /etc/bind/named.conf.local
    if [ "$?" -ne "0" ]
    then
	    dialog --yesno 'Deseja usar /etc/bind como local do arquivo db?' 0 0 && dialog --msgbox 'Local definido como: padrão' 0 0 || DIR=$(dialog --stdout --inputbox 'Digite o diretório desejado: ' 0 0)
            TYPE=$(dialog --stdout --menu 'Escolha o tipo da zona:' 0 0 0 master '' slave '')
    else
            dialog --msgbox 'Zona já Existente' 0 0
            exit 0
    fi
    if [ "$TYPE" = "master" ]
    then 
	    echo -e "\nzone \"${IP}.in-addr.arpa\" {\n type master;\n file \"$DIR/db.$IP\";\n};" >> /etc/bind/named.conf.local
        cp /etc/bind/db.empty $DIR/db.$IP
    fi
    if [ "$TYPE" = "slave" ]
    then 
	    MAST=$(dialog --stdout --inputbox 'Digite o IP do Servidor Primário: ' 0 0) 
	    echo -e "\nzone \"${IP}.in-addr.arpa\" {\n type slave;\n masters { $MAST; };\n file \"$DIR/db.slave.$IP\";\n};" >> /etc/bind/named.conf.local
        cp /etc/bind/db.empty $DIR/db.slave.$IP
    fi
    if [ "$?" = "0" ]
    then
            dialog --msgbox 'Zona Criada' 0 0
            echo "${IP}.in-addr-arpa:${DIR}" >> /root/dir.txt
    fi
/etc/bindhelper/bindhelper2.sh
