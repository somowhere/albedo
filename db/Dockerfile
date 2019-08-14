FROM mysql:5.7

MAINTAINER somewhere(somewhere0813@gmail.com)

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY ./db/albedo.sql /docker-entrypoint-initdb.d
