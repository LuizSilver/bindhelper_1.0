#!/bin/bash
for P in $(tac /root/bindhelper.lock) 
do	
	kill -13 $P
	> /root/bindhelper.lock
done
clear
service bind9 restart
