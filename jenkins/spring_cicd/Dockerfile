# First stage: Build the application
FROM openjdk:21-jdk-slim AS build

# Set the working directory
WORKDIR /app

# Copy the Gradle wrapper and build files
COPY jenkins/spring_cicd/gradle gradle
COPY jenkins/spring_cicd/gradlew .
COPY jenkins/spring_cicd/build.gradle .
COPY jenkins/spring_cicd/settings.gradle .

# Give execution permission to the Gradle wrapper
RUN chmod +x gradlew

# Download the dependencies and configure Java toolchain
RUN ./gradlew dependencies --no-daemon

# Copy the source code
COPY jenkins/spring_cicd/src src

# Build the application
RUN ./gradlew build -x test --no-daemon

# Second stage: Create the final image
FROM openjdk:21-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR files from the build stage to a directory
COPY --from=build /app/build/libs/*.jar /app/

# Expose the port the application runs on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/demo-0.0.1-SNAPSHOT.jar"]
