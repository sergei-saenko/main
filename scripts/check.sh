#!/usr/bin/sh
NAME=check.sh
VERSION=0.1
HOST=c3


read -p "Enter hostname" hostname
mysql -h c3 -uroot -pexplorer < select * from list.servers where hostname like "$hostname"


