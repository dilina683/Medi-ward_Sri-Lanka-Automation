FROM maven:3.9.7 as build
WORKDIR /app

COPY ./pom.xml /app/pom.xml
COPY ./src/main/java/group17/HospitalWardManagementSystem/HospitalWardManagementSystemApplication.java /app/src/main/java/group17/HospitalWardManagementSystem/HospitalWardManagementSystemApplication.java

RUN mvn -f /app/pom.xml clean package

COPY . /app
RUN mvn -f /app/pom.xml clean package

FROM openjdk:21-slim
EXPOSE 5000
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]