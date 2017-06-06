FROM centos:centos7
MAINTAINER eleff <david@eleff.net>

RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-6-x86_64/pgdg-ami201503-93-9.3-3.noarch.rpm

RUN yum install pgbouncer -y

ENV container=docker

ENV PG_MAX_CLIENT_CONN 500
ENV PG_DEFAULT_POOL_SIZE 200
ENV PG_SERVER_IDLE_TIMEOUT 500

EXPOSE 6432

# running /etc/init.d/pgbouncer start    will start the service

