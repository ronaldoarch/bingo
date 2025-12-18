#!/bin/bash

# Script para preparar arquivos para deploy em VPS
# Execute no seu computador local

echo "=========================================="
echo "Preparando Deploy para VPS"
echo "=========================================="

VPS_IP=""
VPS_USER="root"

# Solicitar informações da VPS
read -p "IP da VPS: " VPS_IP
read -p "Usuário da VPS (padrão: root): " VPS_USER
VPS_USER=${VPS_USER:-root}

echo ""
echo "Preparando arquivos..."

# 1. Compilar back-end
echo "1. Compilando back-end..."
cd bingo-backend
GOOS=linux GOARCH=amd64 go build -o bingo-backend main.go
if [ $? -eq 0 ]; then
    echo "✓ Back-end compilado!"
else
    echo "✗ Erro ao compilar back-end"
    exit 1
fi
cd ..

# 2. Compilar front-end
echo "2. Compilando front-end..."
cd bingo-frontend
echo "REACT_APP_API_URL=http://$VPS_IP:8080" > .env.production
npm run build
if [ $? -eq 0 ]; then
    echo "✓ Front-end compilado!"
else
    echo "✗ Erro ao compilar front-end"
    exit 1
fi
cd ..

echo ""
echo "=========================================="
echo "Arquivos prontos!"
echo "=========================================="
echo ""
echo "Próximos passos na VPS:"
echo ""
echo "1. Fazer upload do back-end:"
echo "   scp bingo-backend/bingo-backend $VPS_USER@$VPS_IP:/opt/bingo-backend/"
echo "   scp bingo-backend/env.template $VPS_USER@$VPS_IP:/opt/bingo-backend/.env"
echo ""
echo "2. Fazer upload do front-end:"
echo "   scp -r bingo-frontend/build/* $VPS_USER@$VPS_IP:/var/www/bingo/"
echo ""
echo "3. Na VPS, configure:"
echo "   - Banco de dados MySQL"
echo "   - Arquivo .env com credenciais"
echo "   - Serviço systemd"
echo "   - Nginx como proxy reverso"
echo ""
echo "Veja DEPLOY_VPS.md para instruções completas!"

