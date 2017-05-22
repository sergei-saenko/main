#!/usr/bin/sh
NAME=check.sh
VERSION=0.8
HOST=c3
USER=root
PASS=explorer
mysql="/usr/bin/mysql -u $USER -p$PASS -D list -e"

#3 select system-number
#4 count servers by customers - quantity/percantage (descending)
#5 count servers by primary admin (descending)
#6 remove server from base
#7 add new server to the base (in case it doesn't exist)

case $1 in

	h|host) $mysql "select ser.name as HOSTNAME, ad1.surname as 'PRIMARY', ad2.surname as 'SECONDARY',
			sys.system_id as 'SYSTEM NUM',sys.system_name as 'SYSTEM NAME', cus.name as CUSTOMER  
			from servers ser 
			join admins ad1 
			 on ser.primary_admin_id=ad1.admin_id  
			join admins ad2
			 on ser.secondary_admin_id=ad2.admin_id  
			join customers cus 
			 on ser.customer_id=cus.customer_id  
			join systems sys 
			 on ser.system_id=sys.system_id
			where ser.name like '$2';"
	;;

	l|list)	FILE="$2"
		TBL="tbl`date +%s`"
		$mysql "create table $TBL (name char(30)) engine=memory;
			load data local infile '$FILE' into table $TBL;
			select ser.name as HOSTNAME, ad1.surname as 'PRIMARY', ad2.surname as 'SECONDARY',
			sys.system_id as 'SYSTEM NUM',sys.system_name as 'SYSTEM NAME', cus.name as CUSTOMER  
			from servers ser 
			join admins ad1 
			 on ser.primary_admin_id=ad1.admin_id  
			join admins ad2
			 on ser.secondary_admin_id=ad2.admin_id  
			join customers cus 
			 on ser.customer_id=cus.customer_id  
			join systems sys 
			 on ser.system_id=sys.system_id
			join $TBL
			 on ser.name=$TBL.name;
			drop table $TBL;"
	;;

	a|admin) $mysql "select ser.name as HOSTNAME, ad1.surname as 'PRIMARY', ad2.surname as 'SECONDARY',
                        sys.system_id as 'SYSTEM NUM',sys.system_name as 'SYSTEM NAME', cus.name as CUSTOMER
                        from servers ser
                        join admins ad1
                         on ser.primary_admin_id=ad1.admin_id
                        join admins ad2
                         on ser.secondary_admin_id=ad2.admin_id
                        join customers cus
                         on ser.customer_id=cus.customer_id
                        join systems sys
                         on ser.system_id=sys.system_id
                        where ad1.surname = '$2';"
	;;
	
	s|stat) case $2 in
		
		c|customer) # customer statistics 
		$mysql "select cus.name as CUSTOMER,count(ser.name) AMOUNT
			from servers ser
			join customers cus
			 on ser.customer_id=cus.customer_id
			group by CUSTOMER
			order by AMOUNT desc;"
		;;

		a|admin)
		# admin statistics
		$mysql "select ad.surname ADMIN,count(ser.name) AMOUNT
			from servers ser
			join admins ad
			 on ser.primary_admin_id=ad.admin_id
			group by ADMIN
			order by AMOUNT desc;"
		;;

		*) $mysql "select cus.name as CUSTOMER,count(ser.name) AMOUNT
                        from servers ser
                        join customers cus
                         on ser.customer_id=cus.customer_id
                        group by CUSTOMER
                        order by AMOUNT desc;"
		;;
		esac
	;;

	*) echo "oops, something went wrong..."
	;;
esac
