#!/bin/bash

LOGFILE="/mnt/c/Users/kirsh/OneDrive/Рабочий стол/DACD/logfile.log"

echo "start of a test"
echo "$(date '+%Y-%m-%d %H:%M:%S') - начало" >> "$LOGFILE"
echo ""

echo "checking internet gng"

sudo ping 8.8.8.8 -c 4 &>/dev/null
if [ $? -eq 0 ]; then
	echo "internet works ts"
else 
	echo "nigga aint working"
fi

echo ""
echo "checking ping"

ping google.com -c 1 &>/dev/null
if [ $? -eq 0 ]; then 
	echo "yo ping works"
else 
	echo "ts pmo fr gang"
fi

echo ""
echo "checking DNS server availability"
	
nslookup google.com &>/dev/null
if [ $? -eq 0 ]; then
	echo "DNS server works"
else
	echo "DNS server doesnt work, or yo doesnt yo internet"
fi

echo "-----------------------------"
echo "checking free space on yo disk"

df -h /

echo ""
echo "checking your file system gng"

if [ "$(whoami)" = "root" ]; then
	badblocks -v /dev/sda1 &>/dev/null
	
	if [ $? -eq 0 ]; then
		echo "no bad blocks found"
	else 
		echo "there may be some bad blocks"
	fi
else
	echo "root is required"
fi	

echo "-----------------------------"
echo "checking CPU load"

grep 'cpu ' /proc/stat | awk '{usage = ($2 + $4)*100/($2+$4+$5)} END {print usage "%"}'

echo ""
echo "checking RAM usage"

free -m | grep "Память:" | awk '{print $3 " MB./" $2 " MB."}'

echo ""
echo "checking status of system services ts pmo fr"

echo "ssh is $(systemctl is-active ssh)"
echo "httpd is $(systemctl is-active httpd)"
echo "mysql is $(systemctl is-active mysql)"

echo ""
echo "checking journals for errors and warnings (to quit the journal press Q on yo keyboard)"

sleep 3

journalctl -p err
journalctl -p warning

echo ""
echo "checking DB"

echo "MySQL is $(systemctl is-active mysql)"
echo "PostgreSQL is $(systemctl is-active postgresql)"

echo ""
echo "checking GUI"

xrandr &>/dev/null
if [ $? -eq 0 ]; then
	echo "GUI works fine"
else
	echo "GUI doesnt work"
fi

echo ""
echo "end of a test"