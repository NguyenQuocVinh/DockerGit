#
#run step1.sh :
#step2.sh <container name>

_contain_name=$1

# name of image must be same in step1.sh
# _contain_name variable is container name. 
# 
# that must be same in step3.sh
# hostname is the same in other steps
# Container mounts host directories:
#		/u01/app	: for software oracle
#		/u01/oradata	: for data oracle
#		/soft		: source of 11G.2.0.4
# prepare for install software oracle: 
#	create directories on host 	/u01/Docker/DockerData/OracleLinux11G/app
#					/u01/Docker/DockerData/OracleLinux11G/oradata
# CREATE COTAINER
# EACH CONTAINER HAS TWO DIRS ITSELF.
#REMEMBER EDITING BEFORE RUN THIS COMMAND
docker run --shm-size=4g --name $_contain_name -dP --hostname ol7-db11r2 --privileged=true \
	--mount  type=bind,source=/u01/Docker/DockerData/OracleLinux11G_instance/app,target=/u01/app \
	--mount  type=bind,source=/u01/Docker/DockerData/OracleLinux11G_instance/oradata,target=/u01/oradata \
	--mount  type=bind,source=/mnt/cdromISO,target=/soft,readonly oracle11g_installed /usr/sbin/init
#REMEMBER EDITING BEFORE RUN THIS COMMAND

docker exec -d $_contain_name /bin/bash -c "chown -R oracle:oinstall /u01/app"
docker exec -d $_contain_name /bin/bash -c "chown -R oracle:oinstall /u01/oradata"
docker exec -d -u oracle -w /home/oracle $_contain_name /bin/bash -c "cat /u01/Docker/install/oracle-env.txt >> ~/.bash_profile"
docker exec -d -u oracle -w /home/oracle $_contain_name /bin/bash -c "mkdir -p /u01/app/oracle/product/11.2.0.4/db_1/"
docker exec -d -u oracle -w /home/oracle $_contain_name /bin/bash -c "mkdir -p /u01/app/oraInventory/"
docker exec -d -u oracle -w /home/oracle $_contain_name /bin/bash -c "mkdir -p /u01/app/oracle/admin/adump/"
docker exec -d -u oracle -w /home/oracle $_contain_name /bin/bash -c "mkdir -p /u01/oradata/flash_recovery_area/archivelog/"
docker exec -it $_contain_name /bin/bash

#------------------------------------------------------------
# INSTALL SOFTWARE ORACLE
# RUNING THIS PART IN TERMINAL
#su - oracle
# 
#cd /u01/Docker/install/ && /soft/runInstaller -showProgress -ignoreSysPrereqs -ignorePrereq -silent -responseFile /u01/Docker/install/softinstance.rsp

#OR

#all parameters of response put in this command
#cd /u01/Docker/install/ && /soft/runInstaller -showProgress -ignorePrereq -silent -responseFile /soft/response/db_install.rsp oracle.install.option=INSTALL_DB_SWONLY ORACLE_HOSTNAME=$ORACLE_HOSTNAME UNIX_GROUP_NAME=oinstall INVENTORY_LOCATION=$ORACLE_INVENTORY SELECTED_LANGUAGES=en ORACLE_HOME=$ORACLE_HOME ORACLE_BASE=$ORACLE_BASE oracle.install.db.InstallEdition=EE oracle.install.db.DBA_GROUP=dba oracle.install.db.OPER_GROUP=oper SECURITY_UPDATES_VIA_MYORACLESUPPORT=false  DECLINE_SECURITY_UPDATES=true
# RUNING THIS PART IN TERMINAL
