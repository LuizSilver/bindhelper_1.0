#!/bin/bash
echo $$ >> /root/bindhelper.lock 
OPC=$(dialog --backtitle 'BindHelper 1.0' --title 'Opções de Zona' --stdout --cancel-label 'Voltar' --menu 'Selecione uma função:' 0 0 0 "Criar Zona" '' "Deletar Zona" '' "Visualizar Zonas" '') 
[[ $? -ne '0' ]] && /bin/bindhelper
[[ $OPC == "Criar Zona" ]] && OPC2=$(dialog --stdout --menu 'Selecione o tipo:' 0 0 0 "Zona Direta" '' "Zona Reversa" '') && [[ $OPC2 == "Zona Direta" ]] && /etc/bindhelper/zone.sh || [[ $OPC2 == "Zona Reversa" ]] && /etc/bindhelper/enoz.sh 
[[ $OPC == "Deletar Zona" ]] && /etc/bindhelper/rzone.sh 
[[ $OPC == "Visualizar Zonas" ]] && /etc/bindhelper/view.sh