#!/bin/bash

# Script para verificar status do back-end

cd ~/bingo-backend

if [ -f "bingo.pid" ]; then
    PID=$(cat bingo.pid)
    if ps -p $PID > /dev/null 2>&1; then
        echo "=========================================="
        echo "Back-end está RODANDO"
        echo "=========================================="
        echo "PID: $PID"
        echo "Porta: 8080"
        echo ""
        echo "Últimas linhas do log:"
        tail -n 5 bingo.log
    else
        echo "Back-end NÃO está rodando (PID antigo encontrado)"
        rm bingo.pid
    fi
else
    PID=$(ps aux | grep '[b]ingo-backend' | awk '{print $2}')
    if [ -n "$PID" ]; then
        echo "Back-end está rodando (PID: $PID)"
    else
        echo "Back-end NÃO está rodando"
    fi
fi

