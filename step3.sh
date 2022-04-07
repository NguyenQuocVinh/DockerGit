#Create instance db01
_container='ol7-db11r2'
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'db01:/u01/app/oracle/product/11.2.0.4/db_1/:N' >> /etc/oratab"
docker exec -d -u oracle $_container /bin/bash -c "cp /u01/Docker/install/initdb01.ora /u01/app/oracle/product/11.2.0.4/db_1/dbs/"

docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'export ORAENV_ASK=NO' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '. oraenv' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'sqlplus / as sysdba <<EOF' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'create spfile from pfile;' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'startup nomount' >> /tmp/create_instance.txt"
_x='CREATE DATABASE \"db01\"'
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo $_x >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'USER SYS IDENTIFIED BY abc123 USER SYSTEM IDENTIFIED BY abc123' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'EXTENT MANAGEMENT LOCAL' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'DEFAULT TEMPORARY TABLESPACE temp UNDO TABLESPACE undotbs1 DEFAULT TABLESPACE users datafile size 500M;' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '@?/rdbms/admin/catalog.sql' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '@?/rdbms/admin/catproc.sql' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '@?/rdbms/admin/utlrp.sql' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'exit' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'EOF' >> /tmp/create_instance.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c ". .bash_profile && sh /tmp/create_instance.txt > /tmp/create_instance.log"

docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'export ORAENV_ASK=NO' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '. oraenv' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'sqlplus system/abc123 <<EOF' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo '@?/sqlplus/admin/pupbld.sql' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'exit' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "echo 'EOF' >> /tmp/create_instance2.txt"
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c ". .bash_profile && sh /tmp/create_instance2.txt > /tmp/create_instance2.log"

docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "export ORAENV_ASK=NO && . oraenv && orapwd file=orapwdb01 password=ABC entries=5 force=y"

# lenh nay nen chay rieng de kiem tra
docker exec -d -u oracle -w /home/oracle $_container /bin/bash -c "export ORAENV_ASK=NO && . oraenv && lsnrctl start"
