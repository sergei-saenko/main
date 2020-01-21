#!/bin/bash
#AUTHOR=Sergei Saenko
#EDITORS=Sergei Saenko
#DATE=05.07.2019
#Advice: copy this script to your machine's (Linux/MacOSX) "/usr/local/bin" directory
#Info: tested with Cisco AnyConnect Secure Mobility Client (version 4.2.04039)

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
GRY="\033[1;33;44m"
NEUTRAL="\033[0;39;49m"


#Script block
evr_usernm=
evr_gateway=
infpls_usernm=
infpls_gateway=
infpls_pass=''
vpnexec=/usr/local/bin/openconnect

case $1 in
	connect|c) 

		   if [ "$2" == "evr" ]
                    then
		     echo
		     echo -en "${YELLOW}Enter your RSA:${NC}${GREEN} "
		     read RSA
                     echo -e "\n"
                     echo -e ${BLUE}
		     echo $RSA|/usr/bin/sudo $vpnexec -u $evr_usernm --passwd-on-stdin $evr_gateway -b -q -l 2>/dev/null
	           elif [ "$2" == "pulse" ]
                    then 
                     echo -e ${BLUE}
                     echo $infpls_pass|/usr/bin/sudo $vpnexec -u $infpls_usernm --passwd-on-stdin $infpls_gateway -b -q -l 2>/dev/null
                   else 
                    echo "Please, specify 2nd argument"
                   fi
	;;

	disconnect|d) echo -e ${BLUE}
		      /usr/bin/sudo pkill openconnect
	;;
	
	state|s) echo -e ${BLUE}
		 ps -ef|grep openconnect|grep -v grep|awk -F '/' '{print $5}'|awk '{print "ESTABLISHED: "$5}'
                 echo
	;;

	*) echo
	   $vpnexec -v|grep "Secure Mobility Client"|grep version
           echo -e "\nUsage: vpn connect(c)|disconnect(d)|state(s)\n"
	;;
esac


