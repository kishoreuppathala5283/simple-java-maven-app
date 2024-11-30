# Use the official OpenJDK 17 slim image as the base
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory
WORKDIR /app

# Copy the Maven pom.xml file to the working directory
COPY pom.xml .

# Download dependencies to go offline for faster builds
RUN mvn dependency:go-offline

# Copy the rest of the application code
COPY src /app/src

# Build the application using Maven
RUN mvn clean package -DskipTests

# Expose the application's port
EXPOSE 8082

# Copy the built JAR file and set the entrypoint
COPY target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]


