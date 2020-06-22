FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

ENV TZ=Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p /albedo-quartz

WORKDIR /albedo-quartz

EXPOSE 8011

ADD ./albedo-modules/albedo-quartz/target/albedo-quartz.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-quartz.jar
