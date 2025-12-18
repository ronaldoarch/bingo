#!/bin/bash

# Script para iniciar o back-end em produção
# Configure com as credenciais reais do MySQL

cd ~/bingo-backend

# Configurar variáveis de ambiente do MySQL
export DB_USER="u127271520_bingo"
export DB_PASSWORD="2403Auror@"
export DB_HOST="127.0.0.1"
export DB_PORT="3306"
export DB_NAME="u127271520_bingo"
export PORT="8080"

# Iniciar o servidor
./bingo-backend

