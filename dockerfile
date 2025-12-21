# Use Maven to build the app
FROM maven:3.8.8-openjdk-8 AS build

# Set workdir
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use a lightweight JDK for running
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar ./spring-petclinic.jar

# Expose default port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
