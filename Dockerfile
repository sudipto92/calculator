FROM docker.io/frolvlad/alpine-oraclejre8
COPY build/libs/TestGradle_Jenkinsfile-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
