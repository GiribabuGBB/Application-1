FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/employee-app-1.0.0.jar app.jar

CMD ["java", "-jar", "app.jar"]
