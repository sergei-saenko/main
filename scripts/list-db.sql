select servers.server_name,admins.surname,systems.system_name,customers.name 
from servers 
join admins on servers.primary_admin_id=admins.admin_id and servers.secondary_admin=admins.admin_id
join customers on servers.customer_id=customers.customer_id 
join systems on servers.system_id=systems.system_id where servers.server_name = 'ahpdwf01';




select t1.server_name as HOSTNAME, t2.surname as 'PRIMARY', t3.surname as 'SECONDARY',
t4.system_id as 'SYSTEM NUM',t4.system_name as 'SYSTEM NAME', t5.name as CUSTOMER  
from servers t1, admins t2, admins t3, systems t4, customers t5  
where t1.primary_admin_id=t2.admin_id  
and t1.secondary_admin_id=t3.admin_id  
and t1.customer_id=t5.customer_id  
and t1.system_id=t4.system_id 
and t1.server_name = 'ahpdwf01';


select @start := curtime(4);select ser.server_name as HOSTNAME, ad1.surname as 'PRIMARY', ad2.surname as 'SECONDARY',
sys.system_id as 'SYSTEM NUM',sys.system_name as 'SYSTEM NAME', cus.name as CUSTOMER  
from servers ser, admins ad1, admins ad2, systems sys, customers cus  
where ser.primary_admin_id=ad1.admin_id  
and ser.secondary_admin_id=ad2.admin_id  
and ser.customer_id=cus.customer_id  
and ser.system_id=sys.system_id; select @stop := curtime(4); select @start;select @stop;


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
join tab1
on ser.name=tab1.name;


select cus.name as CUSTOMER,count(ser.name) AMOUNT
from servers ser
join admins ad
on ser.customer_id=cus.customer_id
group by CUSTOMER
order by AMOUNT desc;

select ad.surname ADMIN,count(ser.name) AMOUNT
from servers ser
join admins ad
on ser.primary_admin_id=ad.admin_id
group by ADMIN
order by AMOUNT desc;

select ser.name as HOSTNAME, ad1.surname as 'PRIMARY', 
ad2.surname as 'SECONDARY',sys.system_id as 'SYSTEM NUM',
sys.system_name as 'SYSTEM NAME', cus.name as CUSTOMER
from servers ser,tbl1495579831 tbl,admins ad1,admins ad2,
customers cus,systems sys
where ser.name=tbl.name
and ser.primary_admin_id=ad1.admin_id
and ser.secondary_admin_id=ad2.admin_id
and ser.customer_id=cus.customer_id
and ser.system_id=sys.system_id;


