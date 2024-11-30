# Use an official OpenJDK base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the pom.xml and other dependencies to the container
COPY pom.xml .

#Kishore
# Download dependencies to leverage Docker cache
RUN mvn dependency:go-offline

# Copy the entire project into the container
COPY . .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Expose the application port (use your application's actual port)
EXPOSE 8082

# Command to run the application (adjust based on your app's entry point)
CMD ["java", "-jar", "target/my-java-app.jar"]


