#!/usr/bin/env bash

set -e

# ===============================
# Colores
# ===============================
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"

banner() {
clear
echo -e "${CYAN}"
echo "=================================================="
echo "          🏥 CLÍNICA PRO - SPRING BOOT"
echo "=================================================="
echo -e "${NC}"
}

pause() {
echo
read -p "Presiona ENTER para continuar..."
}

kill_port() {
PORT=${1:-8080}

echo -e "${YELLOW}Buscando procesos en el puerto $PORT...${NC}"

if command -v lsof >/dev/null 2>&1; then
    PIDS=$(lsof -ti tcp:$PORT || true)
else
    PIDS=$(netstat -ano 2>/dev/null | awk -v p=":$PORT" '$4~p {print $5}')
fi

if [ -z "$PIDS" ]; then
    echo -e "${GREEN}✔ No existe ningún proceso usando el puerto $PORT${NC}"
    return
fi

echo -e "${RED}Procesos encontrados:${NC} $PIDS"

for pid in $PIDS; do
    kill -9 $pid 2>/dev/null || taskkill //F //PID $pid >/dev/null 2>&1
done

echo -e "${GREEN}✔ Puerto liberado correctamente.${NC}"
}

start_sql_server() {
    CONTAINER_NAME="clinica_sqlserver"
    IMAGE="mcr.microsoft.com/mssql/server:2022-latest"
    DB_NAME="bd_clinica"
    SA_PASSWORD="Clinica2026*"

    if ! command -v docker >/dev/null 2>&1; then
        echo -e "${RED}Docker no está instalado o no está en PATH.${NC}"
        return 1
    fi

    echo -e "${BLUE}Iniciando Docker SQL Server...${NC}"

    if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        docker start "$CONTAINER_NAME" >/dev/null 2>&1 || true
    else
        docker run -d --name "$CONTAINER_NAME" \
            -e "ACCEPT_EULA=Y" \
            -e "MSSQL_PID=Express" \
            -e "SA_PASSWORD=${SA_PASSWORD}" \
            -p 1434:1433 \
            "$IMAGE" >/dev/null
    fi

    echo -e "${YELLOW}Esperando a que SQL Server esté listo...${NC}"
    until docker exec "$CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; do
        sleep 2
    done

    docker exec "$CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$SA_PASSWORD" -Q "IF DB_ID(N'${DB_NAME}') IS NULL CREATE DATABASE [${DB_NAME}]" >/dev/null 2>&1

    echo -e "${GREEN}✔ Docker SQL Server iniciado y base de datos ${DB_NAME} disponible.${NC}"
}

while true
do

banner

echo "Seleccione una opción:"
echo
echo "  1) ▶ Iniciar Sistema Clínico + Docker SQL Server"
echo "  2) 🔥 Liberar puerto 8080"
echo "  3) 🧪 Ejecutar pruebas"
echo "  4) 🧹 Limpiar proyecto"
echo "  5) 📦 Compilar proyecto"
echo "  6) 🔄 Clean + Package"
echo "  7) ❌ Salir"
echo

read -p "Opción: " opcion

case $opcion in

1)
    echo
    start_sql_server
    echo -e "${BLUE}Iniciando Spring Boot...${NC}"
    ./mvnw spring-boot:run
    pause
;;

2)
    echo
    read -p "Puerto [8080]: " puerto
    puerto=${puerto:-8080}
    kill_port "$puerto"
    pause
;;

3)
    echo
    echo -e "${BLUE}Ejecutando pruebas...${NC}"
    ./mvnw test
    pause
;;

4)
    echo
    echo -e "${BLUE}Limpiando proyecto...${NC}"
    ./mvnw clean
    pause
;;

5)
    echo
    echo -e "${BLUE}Compilando proyecto...${NC}"
    ./mvnw package
    pause
;;

6)
    echo
    echo -e "${BLUE}Generando build...${NC}"
    ./mvnw clean package
    pause
;;

7)
    echo
    echo -e "${GREEN}Hasta luego.${NC}"
    exit 0
;;

*)
    echo
    echo -e "${RED}Opción no válida.${NC}"
    pause
;;

esac

done