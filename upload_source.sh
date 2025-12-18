#!/bin/bash

# Script para fazer upload do código-fonte para compilar no servidor
# Uso: ./upload_source.sh

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"
REMOTE_DIR="~/bingo-backend"

echo "=========================================="
echo "Upload do Código-Fonte para Hostinger"
echo "=========================================="

echo "Fazendo upload do código-fonte..."
rsync -avz -e "ssh -p $SSH_PORT" \
  --exclude='.git' \
  --exclude='*.log' \
  bingo-backend/ $SSH_USER@$SSH_HOST:$REMOTE_DIR/

if [ $? -eq 0 ]; then
    echo "✓ Upload concluído!"
    echo ""
    echo "Agora conecte ao servidor e compile:"
    echo "ssh -p $SSH_PORT $SSH_USER@$SSH_HOST"
    echo "cd ~/bingo-backend"
    echo "go build -o bingo-backend main.go"
else
    echo "✗ Erro no upload"
    exit 1
fi

