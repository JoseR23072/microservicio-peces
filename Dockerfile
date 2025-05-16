# Stage 1: compilación con Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
COPY . .

RUN mvn clean package -DskipTests -B

# Stage 2: runtime ligero
FROM openjdk:17
WORKDIR /app
EXPOSE 8080

# Copia el JAR ya compilado desde el primer stage
COPY --from=build /target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]