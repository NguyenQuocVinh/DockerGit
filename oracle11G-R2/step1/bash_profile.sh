dbName=$1
dbHostName=$2
docker exec $dbName /bin/bash -c "echo 'export TMP=/tmp' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export ORACLE_HOSTNAME=$dbHostName' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export ORACLE_UNQNAME=$dbName' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export ORACLE_BASE=/u01/app/oracle' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0.4/db_1' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export ORACLE_SID=$dbName' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export PATH=/usr/sbin:\$PATH:\$ORACLE_HOME/bin' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib' >> /home/oracle/.bash_profile"
docker exec $dbName /bin/bash -c "echo 'export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib' >> /home/oracle/.bash_profile"

var="alias ob=\'cd \\\$ORACLE_BASE\'"
docker exec $dbName /bin/bash -c "echo $var  >> /home/oracle/.bash_profile"

var="alias oh=\'cd \\\$ORACLE_HOME\'"
docker exec $dbName /bin/bash -c "echo $var >> /home/oracle/.bash_profile"

var="alias tns=\'cd \\\$ORACLE_HOME/network/admin\'"
docker exec $dbName /bin/bash -c "echo $var >> /home/oracle/.bash_profile"

var="alias envo=\'env \| grep ORACLE\'"
docker exec $dbName /bin/bash -c "echo $var >> /home/oracle/.bash_profile"

docker exec $dbName /bin/bash -c "echo 'umask 022' >> /home/oracle/.bash_profile"
