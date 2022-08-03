FROM java:8
VOLUME /tmp
ADD target/*.jar spring-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/spring-petclinic.jar"]
