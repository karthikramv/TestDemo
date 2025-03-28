# Use a compatible Java runtime image
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# Set the working directory
WORKDIR /opt/app

# Copy only the pom.xml first to leverage Docker cache
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy the entire source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Create a lightweight runtime image
FROM eclipse-temurin:21-jdk-alpine

# Copy the built jar file
COPY --from=build /opt/app/target/*.jar /app/app.jar

# Set the working directory
WORKDIR /app

# Expose port if needed (uncomment and adjust as necessary)
# EXPOSE 8080

# Specify the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]