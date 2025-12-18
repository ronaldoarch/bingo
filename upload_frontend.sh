#!/bin/bash

# Script para fazer upload do front-end para o servidor Hostinger
# Uso: ./upload_frontend.sh

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"
REMOTE_DIR="~/public_html"

echo "=========================================="
echo "Upload do Front-end para Hostinger"
echo "=========================================="

# Verificar se a pasta build existe
if [ ! -d "bingo-frontend/build" ]; then
    echo "Erro: Pasta build não encontrada!"
    echo "Execute: cd bingo-frontend && npm run build"
    exit 1
fi

echo "Fazendo upload dos arquivos do front-end..."
scp -P $SSH_PORT -r bingo-frontend/build/* $SSH_USER@$SSH_HOST:$REMOTE_DIR/

if [ $? -eq 0 ]; then
    echo "✓ Upload concluído!"
else
    echo "✗ Erro no upload"
    exit 1
fi

echo ""
echo "=========================================="
echo "Upload concluído!"
echo "=========================================="
echo ""
echo "Acesse: http://$SSH_HOST"
echo ""

