#!/bin/bash

#Color block
GREEN='\033[1;32m'
YELLOW='\033[0;33m'
RED='\033[1;31m'
UNDLN_RED='\033[4;31m'
BOLD_WHITE='\033[1m'
BLACK_ON_RED='\033[1;30;41m'
BLACK_ON_YELLOW='\033[1;30;43m'
BLUE='\033[1;34m'
NC='\033[0m'
UKR="\033[1;37;42m"
NEUTRAL="\033[0;39;49m"


USER="et0529"
PASS="!Nimelig.2020"
PROCESS="`ps -ef|grep ExitOnForwardFailure|grep -v grep|awk '{print $2}'`"
case $1 in

	c|connect)	echo -e "${BOLD_WHITE}TUNNEL: connecting...\n"	
			sleep 1
			if [ -n "$PROCESS" ]	
			then echo -e "\n${BOLD_WHITE}Tunnel is already running: ${GREEN}$PROCESS\n"
			else echo -e "\n${BLUE}Starting tunel..."
			/usr/bin/expect <<- DONE
			set timeout -1
			spawn ssh $USER@ilp-alfine -q -f -n -o ExitOnForwardFailure=yes -C -2 -N -D 127.0.0.1:12345
			expect "et0529@ilp-alfine's password:"
			send -- "$PASS"
			send -- "\r"
			expect eof
			DONE
			echo -e "\n${NEUTRAL}Tunnel has started: ${GREEN}`ps -ef|grep ExitOnForwardFailure|grep -v grep|awk '{print $2}'`\n"
			fi
	;;

	d|disconnect) 	echo -e "${BOLD_WHITE}TUNNEL: disconecting...\n"
			sleep 1
			if [ -n "$PROCESS" ]
			then /bin/kill -9 $PROCESS
			echo -e "${NEUTRAL}Tunnel is closed\n"
			else echo -e "${NEUTRAL}Tunel is not running\n"
			fi
	;;

	s|status) 	echo -e "${BOLD_WHITE}TUNNEL: checking status...\n"
			sleep 1
			if [ -n "$PROCESS" ]
			then echo -e "${GREEN}Running: ${GREEN}$PROCESS\n"
			else echo -e "${YELLOW}Not running\n"
			fi

	;;

	*)	echo -e "${BOLD_WHITE}USAGE: ${NC}tunel {c|connect;d|disconnect;s|status}\n"
	;;

esac
