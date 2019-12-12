#!/bin/bash
echo $$ >> /root/bindhelper.lock 
clear 
while : 
do
  DIR="/etc/bind"
  while :
  do
    ZONE=$(dialog --title 'Criar Zona' --stdout --inputbox 'Digite o Nome da Zona: ' 0 0)
    if [ "$?" -ne "0" ]
    then
	    /etc/bindhelper/bindhelper2.sh
    fi
    grep $ZONE /etc/bind/named.conf.local
    if [ "$?" -ne "0" ]
    then
	    dialog --yesno 'Deseja usar /etc/bind como local do arquivo db?' 0 0 && dialog --msgbox 'Local definido como: padrão' 0 0 || DIR=$(dialog --stdout --inputbox 'Digite o diretório desejado: ' 0 0)
	    TYPE=$(dialog --stdout --menu 'Escolha o tipo da zona:' 0 0 0 master '' slave '')
    else
	    dialog --msgbox 'Zona já Existente' 0 0
	    break
    fi
    if [ "$TYPE" = "master" ]
    then 
	    echo -e "\nzone \"$ZONE\" {\n type master;\n file \"$DIR/db.$ZONE\";\n};" >> /etc/bind/named.conf.local
	cp /etc/bind/db.empty $DIR/db.$ZONE
    fi
    if [ "$TYPE" = "slave" ]
    then 
	    MAST=$(dialog --stdout --inputbox 'Digite o IP do Servidor Primário: ' 0 0) 
	    echo -e "\nzone \"$ZONE\" {\n type slave;\n masters { $MAST; };\n file \"$DIR/db.slave.$ZONE\";\n};" >> /etc/bind/named.conf.local
	cp /etc/bind/db.empty $DIR/db.slave.$ZONE
    fi
    if [ "$?" = "0" ]
    then
	    dialog --msgbox 'Zona Criada' 0 0
	    echo "${ZONE}:${DIR}" >> /root/dir.txt
	    break 2
    fi
  done 
done
/etc/bindhelper/bindhelper2.sh
