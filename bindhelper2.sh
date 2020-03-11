#!/bin/bash
echo $$ >> /root/bindhelper.lock 
OPC=$(dialog --backtitle 'BindHelper 1.0' --title 'Zone Options' --stdout --cancel-label 'Voltar' --menu 'Select a function:' 0 0 0 "Create Zone" '' "Delete Zone" '' "Visualize Zones" '') 
[[ $? -ne '0' ]] && /bin/bindhelper
[[ $OPC == "Create Zone" ]] && OPC2=$(dialog --stdout --menu 'Select the type:' 0 0 0 "Forward Zone" '' "Reverse Zone" '') && [[ $OPC2 == "Forward Zone" ]] && /etc/bindhelper/zone.sh || [[ $OPC2 == "Reverse Zone" ]] && /etc/bindhelper/enoz.sh 
[[ $OPC == "Delete Zone" ]] && /etc/bindhelper/rzone.sh 
[[ $OPC == "Visualize Zones" ]] && /etc/bindhelper/view.sh
