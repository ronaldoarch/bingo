#!/bin/bash

# Script para fazer upload do go.sum corrigido

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"

echo "Fazendo upload do go.sum corrigido..."

scp -P $SSH_PORT bingo-backend/go.sum $SSH_USER@$SSH_HOST:~/bingo-backend/go.sum
scp -P $SSH_PORT bingo-backend/go.mod $SSH_USER@$SSH_HOST:~/bingo-backend/go.mod

if [ $? -eq 0 ]; then
    echo "✓ Arquivos enviados!"
    echo ""
    echo "Agora no servidor execute:"
    echo "  cd ~/bingo-backend"
    echo "  export GOSUMDB=off"
    echo "  go mod tidy"
    echo "  go build -o bingo-backend main.go"
else
    echo "✗ Erro no upload"
    exit 1
fi

