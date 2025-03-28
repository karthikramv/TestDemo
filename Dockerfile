
# First stage: Build the application
FROM eclipse-temurin:21-jdk-alpine AS build

WORKDIR /opt/app

# Install Maven
RUN apk add --no-cache maven

# Copy source code and build the application
COPY . .
RUN mvn clean package -DskipTests

# Second stage: Create the runtime image
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app
COPY --from=build /opt/app/target/*.jar /app/app.jar

# Set the command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]


