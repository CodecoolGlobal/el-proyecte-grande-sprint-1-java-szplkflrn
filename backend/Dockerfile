# Build
FROM maven@sha256:7106ce47b5c226ee21bac386cb706ff9f3db7ac2f15e251e3aa491fcbfc30028 AS build
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:resolve
COPY src ./src
RUN mvn clean package

# Running server
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /usr/local/bin/
COPY --from=build /app/target/bytebattlers-0.0.1-SNAPSHOT.jar bytebattlers.jar
ENTRYPOINT ["java", "-jar", "bytebattlers.jar"]