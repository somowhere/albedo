FROM openjdk:8 as builder
WORKDIR /build
ARG JAR_FILE=target/albedo-admin.jar
COPY ${JAR_FILE} app.jar
RUN java -Djarmode=layertools -jar app.jar extract && rm app.jar

FROM openjdk:8
LABEL maintainer="somewhere0813@gmail.com"
ENV TZ=Asia/Shanghai JAVA_OPTS="-Xms128m -Xmx256m -Djava.security.egd=fileDo:/dev/./urandom"
WORKDIR albedo-admin

COPY --from=builder /build/dependencies/ ./
COPY --from=builder /build/snapshot-dependencies/ ./
COPY --from=builder /build/spring-boot-loader/ ./
COPY --from=builder /build/application/ ./

EXPOSE 4000

CMD sleep 10; java $JAVA_OPTS org.springframework.boot.loader.JarLauncher
