#!/bin/bash

# Script para fazer upload correto do front-end
# Garante que os arquivos vão diretamente para public_html

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"
REMOTE_DIR="~/public_html"

echo "=========================================="
echo "Upload Correto do Front-end"
echo "=========================================="

# Verificar se a pasta build existe
if [ ! -d "bingo-frontend/build" ]; then
    echo "Erro: Pasta build não encontrada!"
    echo "Execute: cd bingo-frontend && npm run build"
    exit 1
fi

cd bingo-frontend/build

echo "Verificando arquivos na pasta build..."
ls -la

echo ""
echo "Fazendo upload dos arquivos..."
echo ""

# Upload dos arquivos principais (sem subdiretório)
scp -P $SSH_PORT index.html asset-manifest.json $SSH_USER@$SSH_HOST:$REMOTE_DIR/

# Upload da pasta static
if [ -d "static" ]; then
    echo "Fazendo upload da pasta static..."
    scp -P $SSH_PORT -r static $SSH_USER@$SSH_HOST:$REMOTE_DIR/
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Upload concluído!"
    echo ""
    echo "Verifique no servidor:"
    echo "  ssh -p $SSH_PORT $SSH_USER@$SSH_HOST"
    echo "  ls -la ~/public_html/"
    echo ""
    echo "Acesse: http://$SSH_HOST"
else
    echo "✗ Erro no upload"
    exit 1
fi

