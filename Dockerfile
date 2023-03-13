FROM openjdk:8
EXPOSE 8080
ADD target/devops-integration.jar devops-integration.jar
RUN adduser -D userone
USER userone
ENTRYPOINT ["java","-jar","/devops-integration.jar"]