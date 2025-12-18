#!/bin/bash

# Script para parar o back-end

cd ~/bingo-backend

if [ -f "bingo.pid" ]; then
    PID=$(cat bingo.pid)
    if ps -p $PID > /dev/null 2>&1; then
        kill $PID
        rm bingo.pid
        echo "Back-end parado (PID: $PID)"
    else
        echo "Processo não está rodando"
        rm bingo.pid
    fi
else
    echo "Arquivo bingo.pid não encontrado"
    echo "Tentando encontrar processo manualmente..."
    PID=$(ps aux | grep '[b]ingo-backend' | awk '{print $2}')
    if [ -n "$PID" ]; then
        kill $PID
        echo "Back-end parado (PID: $PID)"
    else
        echo "Nenhum processo encontrado"
    fi
fi

