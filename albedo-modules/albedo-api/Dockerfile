FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /albedo-api

WORKDIR /albedo-api

EXPOSE 4001

ADD ./albedo-modules/albedo-api/target/albedo-api.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-api.jar
