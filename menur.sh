#!/bin/bash
echo $$ >> /root/bindhelper.lock
OPC=$(dialog --backtitle "BindHelper 1.0" --stdout --cancel-label "Back" --menu "Select a function:" 0 0 0 "Create Record" '' "Delete Record" '' "Visualize db" '')
[[ $? -ne 0 ]] && /bin/bindhelper
[[ $OPC == "Create Record" ]] && /etc/bindhelper/reg.sh
[[ $OPC == "Delete Record" ]] && /etc/bindhelper/rreg.sh
[[ $OPC == "Visualize db" ]] && /etc/bindhelper/viewr.sh
