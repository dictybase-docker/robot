FROM maven:3.6.1-jdk-8-alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache git bash
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY pom.xml ./
ADD robot-command robot-command
ADD robot-core robot-core
ADD robot-maven-plugin robot-maven-plugin
RUN mvn install -q -DskipTests

FROM openjdk:8u212-jre-alpine3.9
COPY bin/robot /usr/local/bin/
COPY --from=0 /usr/src/app/bin/robot.jar /usr/local/bin
