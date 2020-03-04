FROM frolvlad/alpine-oraclejre8:slim
COPY build/libs/TestGradle_Jenkinsfile-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
