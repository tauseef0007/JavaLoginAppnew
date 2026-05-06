#BUild Stage --1

FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src .src 
RUN mvn clean packages -DskipTests

# RUN stage --2

FROM tomcat:10.1-jre17-temurin
RUN rm -rf usr/local/tomcat/webapps/*
COPY --from=build app/tomcat/*.war usr/locat/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]