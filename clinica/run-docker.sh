#!/usr/bin/env bash
set -e

# Build and run the ClinicX Spring Boot app in Docker.
#
# Why Docker: on this Windows machine AF_UNIX (Unix domain sockets) is broken
# at the OS level. Every JDK 17+ (required by Spring Boot 4) opens its NIO
# selector via an AF_UNIX self-pipe, so Tomcat cannot start on the host and
# the app dies with "Unable to establish loopback connection". Running on
# Linux (Docker) sidesteps this entirely.
#
# Prerequisite: SQL Server must be reachable on host port 1434
# (the clinica_sqlserver container, e.g. started by start.sh or docker compose).

cd "$(dirname "$0")"

echo "==> Packaging JAR (skipping tests)..."
./mvnw -DskipTests package

echo "==> Building Docker image 'clinicx-app'..."
docker build -t clinicx-app .

echo "==> (Re)starting container 'clinicx_app' on port 8080..."
docker rm -f clinicx_app >/dev/null 2>&1 || true
docker run -d --name clinicx_app \
  -p 8080:8080 \
  --add-host host.docker.internal:host-gateway \
  -e "SPRING_DATASOURCE_URL=jdbc:sqlserver://host.docker.internal:1434;databaseName=bd_clinica;encrypt=true;trustServerCertificate=true;" \
  clinicx-app

echo "==> App is starting (~70s). Follow logs with:  docker logs -f clinicx_app"
echo "==> When ready, open:  http://localhost:8080"
