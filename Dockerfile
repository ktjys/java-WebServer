FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8080
ARG JAR_FILE=target/java-WebServer-0.1-jar-with-dependencies.jar
ADD ${JAR_FILE} webserver.jar
ENTRYPOINT ["java","-jar","/webserver.jar", "8080"]
