FROM openjdk:21-jdk-slim

#LABEL maintainer="Franchis Janel MOKOMBA janelaffranchis@gmail.com"

#EXPOSE 8000

#RUN mkdir -p /app/data

#ADD docker/dockervolume.jar dockervolume.jar

#WORKDIR /app/data

#ENTRYPOINT ["java", "-jar", "dockervolume.jar"]

# Utilisez une image de base Java
#FROM openjdk:11-jdk-slim as build

# Définissez le répertoire de travail
WORKDIR /app/data

# Copiez le fichier pom.xml et créez le répertoire .m2 pour les dépendances Maven
COPY pom.xml .
COPY src ./src
RUN mvn -B dependency:go-offline

# Compilez l'application
RUN mvn package -DskipTests

# Utilisez une image de base pour l'exécution
#FROM openjdk:11-jre-slim

# Copiez le fichier JAR de l'étape de build
COPY --from=build /app/data/target/*.jar /data/cicd.jar

# Définissez le répertoire de travail
WORKDIR /data

# Exécutez l'application
ENTRYPOINT ["java", "-jar", "cicd.jar"]