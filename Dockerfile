FROM centos:centos7
MAINTAINER eleff <david@eleff.net>


#This chunk of code is needed or you will get:
#'Failed to get D-Bus connection: Operation not permitted'
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

#Make sure there is a pgbouncer to install
RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-6-x86_64/pgdg-ami201503-93-9.3-3.noarch.rpm

RUN yum install pgbouncer -y

#Should probably specify these things
ENV PG_MAX_CLIENT_CONN 500
ENV PG_DEFAULT_POOL_SIZE 200
ENV PG_SERVER_IDLE_TIMEOUT 500

#PostgreSQL and PgBouncer ports, might be good to expose them
EXPOSE 6432
EXPOSE 5432

#Start the PgBouncer service
CMD ["/etc/init.d/pgbouncer","start"]

