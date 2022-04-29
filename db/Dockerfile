FROM mysql:8.0.27

MAINTAINER somewhere(somewhere0813@gmail.com)

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


COPY ./db/albedo.sql /docker-entrypoint-initdb.d
