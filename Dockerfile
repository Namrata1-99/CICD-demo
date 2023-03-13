FROM openjdk:8
EXPOSE 8080
RUN useradd -ms /bin/bash newuser
USER newuser
ADD target/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]