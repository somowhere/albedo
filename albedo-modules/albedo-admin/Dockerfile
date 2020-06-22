FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /albedo-admin

WORKDIR /albedo-admin

EXPOSE 4000

ADD ./albedo-modules/albedo-admin/target/albedo-admin.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-admin.jar
