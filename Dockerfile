# Step 1: Build the app with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the app with JDK 17
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expose port (Render will override with $PORT)
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
