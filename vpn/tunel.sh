#!/usr/bin/expect -f
set timeout -1
set USER "et0529"
set PASS "!Nimelig.2020"

case $1 in 


	s|start)	spawn ssh $USER@ilp-alfine -q -f -n -o ExitOnForwardFailure=yes -C -2 -N -D 127.0.0.1:12345
			expect "et0529@ilp-alfine's password:"
			send "$PASS\r"
			interact
		;;

	stop)		/bin/kill -9 `ps -ef|grep 'ExitOnForwardFailure'|grep -v grep|awk '{print $2}'`
		;;

	*)		echo -e "usage: tunel {start|stop}\n"
		;;
esac
