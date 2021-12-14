#!/bin/bash

ARCHITECTURE=$(uname -a)
PCPU=$(lscpu | grep "CPU(s)" | awk 'NR == 1 {print $2}')
VCPU=$(cat /proc/cpuinfo | grep processor | wc -l)
MEM=$(free -m | awk 'NR == 2 {printf "%s/%sMB (%.2f%%)", $3, $2, ($3/$2*100)}')
DISK=$(df -h | awk 'NR == 4 {printf "%s/%s (%.2f%%)", $3, $2, ($3/$2*100)}')
CPU_LOAD=$(top -bn1 | awk 'NR==3 {print $2"%"}')
L_BOOT=$(who -b | awk '{print $3" "$4}')
LVM=$(lsblk |grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"}}')
TCP=$(netstat -anp | grep ESTABLISHED | wc -l)
USER=$(who | wc -l)
IP=$(/sbin/ifconfig | awk 'NR == 2 {print $2}')
MAC=$(/sbin/ifconfig | awk 'NR == 4 {print $2}')
SUDO=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)

wall  "#Architecture: $ARCHITECTURE
#CPU physical : $PCPU
#vCPU : $VCPU
#Memory Usage: $MEM
#Disk Usage: $DISK
#CPU load: $CPU_LOAD
#Last boot: $L_BOOT
#LVM use: $LVM
#Connexions TCP : $TCP ESTABLISHED
#User log: $USER
#Network: IP $IP ($MAC)
#Sudo : $SUDO cmd"
