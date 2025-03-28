# Use a compatible Java runtime image
FROM eclipse-temurin:21-jdk-alpine AS build

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
FROM eclipse-temurin:21-jre-alpine

# Copy the built jar file
COPY --from=build /opt/app/target/*.jar /app/app.jar

# Set the working directory
WORKDIR /app

# Expose port if needed (uncomment and adjust as necessary)
EXPOSE 8081

# Specify the entrypoint
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

