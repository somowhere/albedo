FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /albedo-admin

WORKDIR /albedo-admin

EXPOSE 4000

ADD ./albedo-module/albedo-admin-biz/target/albedo-admin-biz.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-admin-biz.jar
