FROM openjdk:21-jdk-slim

LABEL maintainer="Franchis Janel MOKOMBA janelaffranchis@gmail.com"

EXPOSE 8000

RUN mkdir -p /app/data

ADD docker/dockervolume.jar dockervolume.jar

WORKDIR /app/data

ENTRYPOINT ["java", "-jar", "dockervolume.jar"]