#!/bin/bash

# Script para fazer upload manual (você precisará digitar a senha)
# Uso: ./upload_manual.sh

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"

echo "=========================================="
echo "Upload Manual para Hostinger"
echo "=========================================="
echo ""
echo "Você precisará digitar sua senha SSH"
echo ""

# Upload do código-fonte do back-end
echo "1. Fazendo upload do código-fonte do back-end..."
scp -P $SSH_PORT -r bingo-backend/* $SSH_USER@$SSH_HOST:~/bingo-backend/

if [ $? -eq 0 ]; then
    echo "✓ Back-end enviado!"
else
    echo "✗ Erro no upload do back-end"
    exit 1
fi

echo ""
echo "=========================================="
echo "Upload concluído!"
echo "=========================================="
echo ""
echo "Agora, no servidor, execute:"
echo "  cd ~/bingo-backend"
echo "  go version  # Verificar se Go está instalado"
echo "  go mod download"
echo "  go build -o bingo-backend main.go"
echo "  chmod +x bingo-backend"
echo ""

