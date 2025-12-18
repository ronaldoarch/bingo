#!/bin/bash

# Script para preparar e fazer upload do front-end

echo "=========================================="
echo "Preparando Front-end para Deploy"
echo "=========================================="

cd bingo-frontend

# Verificar se node_modules existe
if [ ! -d "node_modules" ]; then
    echo "Instalando dependências..."
    npm install
fi

# Configurar URL da API
echo "Configurando URL da API..."
echo "REACT_APP_API_URL=http://212.85.6.24:8080" > .env.production

# Fazer build
echo "Fazendo build de produção..."
npm run build

if [ $? -eq 0 ]; then
    echo "✓ Build concluído com sucesso!"
    echo ""
    echo "Próximo passo: fazer upload"
    echo "Execute: ./upload_frontend.sh"
else
    echo "✗ Erro no build"
    exit 1
fi

