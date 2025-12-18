#!/bin/bash

# Script para fazer upload da correção (remover go.sum problemático)

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"

echo "=========================================="
echo "Corrigindo Problema do go.sum"
echo "=========================================="
echo ""
echo "No servidor, execute:"
echo ""
echo "cd ~/bingo-backend"
echo "rm -f go.sum"
echo "export GOSUMDB=off"
echo "go mod tidy"
echo "go build -o bingo-backend main.go"
echo "chmod +x bingo-backend"
echo ""

# Opcional: fazer upload do go.mod atualizado
echo "Fazendo upload do go.mod atualizado..."
scp -P $SSH_PORT bingo-backend/go.mod $SSH_USER@$SSH_HOST:~/bingo-backend/go.mod

if [ $? -eq 0 ]; then
    echo "✓ go.mod enviado!"
    echo ""
    echo "Agora no servidor execute os comandos acima"
else
    echo "✗ Erro no upload (mas você pode continuar sem isso)"
fi

