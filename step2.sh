# name of image must be same in step1.sh
# name of container must be same in step3.sh
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
docker run --shm-size=4g --name ol7-db11r2 -dP --hostname ol7-db11r2 --privileged=true \
	--mount  type=bind,source=/u01/Docker/DockerData/OracleLinux11G/app,target=/u01/app \
	--mount  type=bind,source=/u01/Docker/DockerData/OracleLinux11G/oradata,target=/u01/oradata \
	--mount  type=bind,source=/mnt/cdromISO,target=/soft,readonly oracle11g_installed /usr/sbin/init
#REMEMBER EDITING BEFORE RUN THIS COMMAND

docker exec -d ol7-db11r2 /bin/bash -c "chown -R oracle:oinstall /u01/app"
docker exec -d ol7-db11r2 /bin/bash -c "chown -R oracle:oinstall /u01/oradata"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "cat /u01/Docker/install/oracle-env.txt >> ~/.bash_profile"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "mkdir -p /u01/app/oracle/product/11.2.0.4/db_1/"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "mkdir -p /u01/app/oraInventory/"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "mkdir -p /u01/app/oracle/admin/db01/adump/"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "mkdir -p /u01/oradata/db01/"
docker exec -d -u oracle -w /home/oracle ol7-db11r2 /bin/bash -c "mkdir -p /u01/oradata/flash_recovery_area/db01/archivelog/"

# INSTALL SOFTWARE ORACLE
# RUNING THIS PART IN TERMINAL
#docker exec -it ol7-db11r2 /bin/bash
#su - oracle
#cd /u01/Docker/install/ && /soft/runInstaller -showProgress -ignoreSysPrereqs -ignorePrereq -silent -noconfig -responseFile /u01/Docker/install/softonly.rsp
# RUNING THIS PART IN TERMINAL
