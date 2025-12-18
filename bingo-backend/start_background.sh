#!/bin/bash

# Script para iniciar o back-end em background (sem sudo)
# Use este script na Hostinger onde não há acesso sudo

cd ~/bingo-backend

# Configurar variáveis de ambiente
export DB_USER="u127271520_bingo"
export DB_PASSWORD="2403Auror@"
export DB_HOST="127.0.0.1"
export DB_PORT="3306"
export DB_NAME="u127271520_bingo"
export PORT="8080"

# Iniciar em background e salvar PID
nohup ./bingo-backend > bingo.log 2>&1 &
echo $! > bingo.pid

echo "=========================================="
echo "Back-end iniciado em background!"
echo "=========================================="
echo "PID: $(cat bingo.pid)"
echo "Logs: ~/bingo-backend/bingo.log"
echo ""
echo "Para ver logs: tail -f ~/bingo-backend/bingo.log"
echo "Para parar: kill \$(cat ~/bingo-backend/bingo.pid)"
echo ""

