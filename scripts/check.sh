#!/usr/bin/sh
NAME=check.sh
VERSION=0.3
HOST=c3
USER=root
PASS=explorer
mysql="/usr/bin/mysql -u$USER -p$PASS -e"

#1 select server/group_of_servers
#2 select admin
#3 select system-number
#4 count servers by customers - quantity/percantage (descending)
#5 count servers by primary admin (descending)
#6 remove server from base
#7 add new server to the base (in case it doesn't exist)

case $1 in

h|host)  read -p "Enter hostname: " hostname
    if [ -n $hostname ]
        then
        $mysql "select * from list.servers where hostname like '$hostname'"
    fi
;;

a|admin)  read -p "Enter surname: " surname
    if [ -n $surname ]
        then
        $mysql "select * from list.servers where primary_admin like '$surname'"
    fi
;;
*) echo "oops, something went wrong..."
;;
esac
