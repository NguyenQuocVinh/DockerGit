FROM oraclelinux:7
MAINTAINER vinhnq  <quocvinh.n@google.com>

RUN yum -y install wget nano vi binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33.i686 gcc gcc-c++ glibc.i686 glibc glibc-devel glibc-devel.i686 ksh libgcc.i686 libgcc libstdc++ libstdc++.i686 libstdc++-devel libstdc++-devel.i686 libaio libaio.i686 libaio-devel libaio-devel.i686 libXext libXext.i686 libXtst libXtst.i686 libX11 libX11.i686 libXau libXau.i686 libxcb libxcb.i686 libXi libXi.i686 make sysstat vte3 smartmontools
RUN yum install -y oracle-database-server-12cR2-preinstall
RUN cd /tmp && wget https://download-ib01.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm -Uvh --force epel*.rpm
RUN yum install -y rlwrap

RUN echo "oracle:abc123" | chpasswd

ADD sysctl.conf /etc/sysctl.conf
RUN echo "oracle soft stack 10240" >> /etc/security/limits.conf

ADD softonly.rsp /u01/Docker/install/softonly.rsp
ADD install /u01/Docker/install/install
ADD initdb01.ora /u01/Docker/install/initdb01.ora

ADD oracle-env.txt /u01/Docker/install/oracle-env.txt
EXPOSE 1521
