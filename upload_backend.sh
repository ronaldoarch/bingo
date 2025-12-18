#!/bin/bash

# Script para fazer upload do back-end para o servidor Hostinger
# Uso: ./upload_backend.sh

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"
REMOTE_DIR="~/bingo-backend"

echo "=========================================="
echo "Upload do Back-end para Hostinger"
echo "=========================================="

# Verificar se o arquivo existe
if [ ! -f "deploy/bingo-backend" ]; then
    echo "Erro: Arquivo bingo-backend não encontrado!"
    echo "Execute ./deploy.sh primeiro"
    exit 1
fi

echo "Fazendo upload do executável..."
scp -P $SSH_PORT deploy/bingo-backend $SSH_USER@$SSH_HOST:$REMOTE_DIR/

if [ $? -eq 0 ]; then
    echo "✓ Upload concluído!"
else
    echo "✗ Erro no upload"
    exit 1
fi

echo ""
echo "Fazendo upload do template de configuração..."
scp -P $SSH_PORT deploy/backend.env.template $SSH_USER@$SSH_HOST:$REMOTE_DIR/.env.template

if [ $? -eq 0 ]; then
    echo "✓ Template enviado!"
else
    echo "✗ Erro no upload do template"
    exit 1
fi

echo ""
echo "=========================================="
echo "Upload concluído!"
echo "=========================================="
echo ""
echo "Próximos passos no servidor:"
echo "1. Conecte via SSH: ssh -p $SSH_PORT $SSH_USER@$SSH_HOST"
echo "2. Navegue até: cd ~/bingo-backend"
echo "3. Configure: cp .env.template .env && nano .env"
echo "4. Dê permissão: chmod +x bingo-backend"
echo "5. Teste: ./bingo-backend"
echo ""

