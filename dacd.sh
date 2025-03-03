#!/bin/bash

LOGFILE="/mnt/c/Users/kirsh/OneDrive/Рабочий стол/DACD/logfile.log"

echo "start of a test"
echo "$(date '+%Y-%m-%d %H:%M:%S') - начало" >> "$LOGFILE"
echo ""

echo "checking internet gng"

sudo ping 8.8.8.8 -c 4 &>/dev/null
if [ $? -eq 0 ]; then
	echo "internet works ts"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - интернет работает" >> "$LOGFILE"
else 
	echo "nigga aint working"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - интернет не работает" >> "$LOGFILE"
fi

echo ""
echo "checking ping"

ping google.com -c 1 &>/dev/null
if [ $? -eq 0 ]; then 
	echo "yo ping works"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - пинг работает" >> "$LOGFILE"
else 
	echo "ts pmo fr gang"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - пинг не работает" >> "$LOGFILE"
fi

echo ""
echo "checking DNS server availability"
	
nslookup google.com &>/dev/null
if [ $? -eq 0 ]; then
	echo "DNS server works"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - днс сервер работает" >> "$LOGFILE"
else
	echo "DNS server doesnt work, or yo doesnt yo internet"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - днс сервер не работает" >> "$LOGFILE"
fi

echo "-----------------------------"
echo "checking free space on yo disk"

df -h /
echo "$(date '+%Y-%m-%d %H:%M:%S') - предоставлена информацияо свободном месте на диске" >> "$LOGFILE"

echo ""
echo "checking your file system gng"

if [ "$(whoami)" = "root" ]; then
	badblocks -v /dev/sda1 &>/dev/null
	
	if [ $? -eq 0 ]; then
		echo "no bad blocks found"
		echo "$(date '+%Y-%m-%d %H:%M:%S') - нет поврежденных блоков" >> "$LOGFILE"
	else 
		echo "there may be some bad blocks"
		echo "$(date '+%Y-%m-%d %H:%M:%S') - есть поврежденные блоки на диске" >> "$LOGFILE"
	fi
else
	echo "root is required"
	echo "$(date '+%Y-%m-%d %H:%M:%S') - команда badblocks не выполнена" >> "$LOGFILE"
fi	

echo "-----------------------------"
echo "checking CPU load"

grep 'cpu ' /proc/stat | awk '{usage = ($2 + $4)*100/($2+$4+$5)} END {print usage "%"}'
echo "$(date '+%Y-%m-%d %H:%M:%S') - $(grep 'cpu ' /proc/stat | awk '{usage = ($2 + $4)*100/($2+$4+$5)} END {print usage "%"}')" >> "$LOGFILE"

echo ""
echo "checking RAM usage"

free -m | grep "Mem:" | awk '{print $3 " MB./" $2 " MB."}'
echo "$(date '+%Y-%m-%d %H:%M:%S') - $(free -m | grep "Память:" | awk '{print $3 " MB./" $2 " MB."}')" >> "$LOGFILE"

echo ""
echo "checking status of system services ts pmo fr"

echo "ssh is $(systemctl is-active ssh)"
echo "$(date '+%Y-%m-%d %H:%M:%S') - ssh is $(systemctl is-active ssh)" >> "$LOGFILE"

echo "httpd is $(systemctl is-active httpd)"
echo "$(date '+%Y-%m-%d %H:%M:%S') - httpd is $(systemctl is-active httpd)" >> "$LOGFILE"

echo "mysql is $(systemctl is-active mysql)"
echo "$(date '+%Y-%m-%d %H:%M:%S') - mysql is $(systemctl is-active mysql)" >> "$LOGFILE"

echo ""
echo "checking journals for errors and warnings (to quit the journal press Q on yo keyboard)"

sleep 3

journalctl -p err
journalctl -p warning

echo ""
echo "checking DB"

echo "MySQL is $(systemctl is-active mysql)"
echo "$(date '+%Y-%m-%d %H:%M:%S') - mysql is $(systemctl is-active mysql)" >> "$LOGFILE"

echo "PostgreSQL is $(systemctl is-active postgresql)"
echo "$(date '+%Y-%m-%d %H:%M:%S') - postgresql is $(systemctl is-active postgresql)" >> "$LOGFILE"

echo ""
echo "checking GUI"

xrandr &>/dev/null
echo "$(date '+%Y-%m-%d %H:%M:%S') - xrandr" >> "$LOGFILE"
if [ $? -eq 0 ]; then
	echo "GUI works fine"
	
else
	echo "GUI doesnt work"
fi

echo ""
echo "end of a test"