#!/bin/bash

# Script para iniciar o back-end com variáveis de ambiente
# Configure suas credenciais MySQL abaixo

cd ~/bingo-backend

# Configurar variáveis de ambiente do MySQL
# SUBSTITUA COM SUAS CREDENCIAIS REAIS DA HOSTINGER
export DB_USER="seu_usuario_mysql"
export DB_PASSWORD="sua_senha_mysql"
export DB_HOST="localhost"
export DB_PORT="3306"
export DB_NAME="bingo"
export PORT="8080"

# Iniciar o servidor
./bingo-backend

