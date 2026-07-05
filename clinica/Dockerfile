# Runtime image for the ClinicX Spring Boot app.
# The JAR is built on the host (mvnw package) and copied in, so the build
# stays fast and does not re-download dependencies inside Docker.
# Running on Linux sidesteps the Windows AF_UNIX/NIO-selector failure that
# blocks Tomcat from starting under JDK 17+ on the host machine.
FROM eclipse-temurin:24-jre

WORKDIR /app
COPY target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
