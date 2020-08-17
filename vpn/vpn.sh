#!/bin/bash
#AUTHOR=Sergei Saenko
#CONTRIBUTORS=Sergei Saenko
#DATE=23.07.2020
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


#Test notification block
echo -e ${GREEN}
echo "Test mode.
To-do:
+ status function 
+ selector mode
+ file store for credential"
echo -e ${NC}

vpnexec=/opt/cisco/anyconnect/bin/vpn
PROCESS="`ps -ef|grep ExitOnForwardFailure|grep -v grep|awk '{print $2}'`"

if [ "$2" = "infopulse" ]
 then
  username=sergei.saenko
  vpngateway=webvpn3.infopulse.com
elif [ "$2" = "tie" ]
 then
  username=et0529
  vpngateway=vpn.corpcommon.com
  tunel_host=ilp-alfine
  mgmt_pass="!Nova.2020"
elif [ "$1" = "d" ]
 then
  echo
else
  echo
fi

case $1 in
        connect|c) echo
                   echo -e "${BLUE}Cisco AnyConnect VPN${NC}\n"
                   echo -en "${YELLOW}Enter your PASS or RSA:${NC}${GREEN} "
                   read -s PASS 
                   echo -e "\n"
                   echo -e ${BLUE}
                   echo -e "$username\n$PASS\ny" | $vpnexec -s co $vpngateway
                   echo -e ${NC}
                   if [ "$2" = "tie" ]
                   then
                        echo -e "${BOLD_WHITE}COS SSH Tunnel"	
			sleep 1
			if [ -n "$PROCESS" ]	
			  then echo -e "\n${BOLD_WHITE}COS SSH Tunnel is already running: ${GREEN}$PROCESS\n"
			 else echo -e "\n${NEUTRAL}COS SSH Tunnel: authentication..."
			 /usr/bin/expect <<- DONE
			 set timeout -1
			 spawn ssh $username@$tunel_host -q -f -n -o ExitOnForwardFailure=yes -C -2 -N -D 127.0.0.1:12345
			  expect "et0529@ilp-alfine's password:"
			  send -- "$mgmt_pass"
			  send -- "\r"
			  expect eof
			DONE
			echo -e "\n${NEUTRAL}COS SSH Tunnel: has started, PID: ${GREEN}`ps -ef|grep ExitOnForwardFailure|grep -v grep|awk '{print $2}'`\n"
			fi
                   else
                    echo
                   fi 
        ;;

        disconnect|d) echo -e ${BLUE}
                      vpn_profile=`echo "stats" | $vpnexec -s|grep 'Profile Name'|awk '{print $3}'`
                      if [ "$vpn_profile" = "vpn-corp.xml" ]
                      then
                        echo -e "${BOLD_WHITE}COS SSH Tunnel: disconecting...\n"
			sleep 1
			if [ -n "$PROCESS" ]
			 then /bin/kill -9 $PROCESS
			 echo -e "${NEUTRAL}COS SSH Tunnel: ${BOLD_WHITE}closed\n"
                         echo -e ${BLUE}
                         $vpnexec $1
			else 
                          echo -e "${NEUTRAL}COS SSH Tunnel: ${BOLD_WHITE}not running\n"
                          echo -e ${BLUE}
                          $vpnexec $1
			fi
                      elif [ "$vpn_profile" = "RDP-PROFILE-CRO1.xml" ]
                       then
                       echo -e ${BLUE}
                        $vpnexec $1
                      else
                       echo
                      fi
        ;;

        state|s) echo -e ${BLUE}
                 $vpnexec state
        ;;

        *) echo
           $vpnexec -v|grep "Secure Mobility Client"|grep version
           echo -e "\nUsage: vpn connect(c)|disconnect(d)|state(s)\n"
        ;;
esac
