#!/bin/bash
echo $$ >> /root/bindhelper.lock
OPC=$(dialog --backtitle "BindHelper 1.0" --stdout --cancel-label "Voltar" --menu "Selecione uma função:" 0 0 0 "Criar Registro" '' "Deletar Registro" '' "Visualizar db" '')
[[ $? -ne 0 ]] && /bin/bindhelper
[[ $OPC == "Criar Registro" ]] && /etc/bindhelper/reg.sh
[[ $OPC == "Deletar Registro" ]] && /etc/bindhelper/rreg.sh
[[ $OPC == "Visualizar db" ]] && /etc/bindhelper/viewr.sh
