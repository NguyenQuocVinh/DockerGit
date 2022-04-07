#Create instance db01
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "echo 'db01:/u01/app/oracle/product/11.2.0.4/db_1/:N' >> /etc/oratab"
docker exec -d -u oracle ol7-db11r2 /bin/bash -c "cp /u01/Docker/install/initdb01.ora /u01/app/oracle/product/11.2.0.4/db_1/dbs/"

# tam thoi dung o day, se dua may cai nay vo scrip luon
docker exec -u oracle -w /home/oracle -it ol7-db11r2 /bin/bash
. .bash_profile
. oraenv			--> choose sid= db01 and enter
sqlplus / as sysdba
SQL>create spfile from pfile;
SQL>startup nomount
SQL> CREATE DATABASE "db01"
USER SYS IDENTIFIED BY abc123" USER SYSTEM IDENTIFIED BY abc123
EXTENT MANAGEMENT LOCAL 
DEFAULT TEMPORARY TABLESPACE temp UNDO TABLESPACE undotbs1 DEFAULT TABLESPACE users datafile size 500M;
/
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

sqlplus	system/abc123
SQL> @?/sqlplus/admin/pupbld.sql

#create password file
$oh
$orapwd file=orapwdb01 password=ABC entries=5 force=y

#start listener
$lsnrctl start
