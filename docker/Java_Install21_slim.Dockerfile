# First stage: Build the application
FROM openjdk:21-jdk-slim AS build

# Set the working directory
WORKDIR /app

# Copy the Gradle wrapper and build files
COPY gradle gradle
COPY gradlew .
COPY build.gradle .
COPY settings.gradle .

# Download the dependencies and configure Java toolchain
RUN ./gradlew dependencies --no-daemon

# Copy the source code
COPY src src

# Build the application
RUN ./gradlew build -x test --no-daemon

# Second stage: Create the final image
FROM openjdk:21-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
