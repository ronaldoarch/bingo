#!/bin/bash

# Script para testar se o site está acessível

SSH_HOST="212.85.6.24"

echo "=========================================="
echo "Testando Acesso ao Site"
echo "=========================================="
echo ""

echo "1. Testando acesso HTTP:"
echo "   curl http://$SSH_HOST/"
curl -I http://$SSH_HOST/ 2>&1 | head -5

echo ""
echo "2. Testando index.html diretamente:"
curl -I http://$SSH_HOST/index.html 2>&1 | head -5

echo ""
echo "3. Verificando conteúdo (primeiras linhas):"
curl http://$SSH_HOST/ 2>&1 | head -20

echo ""
echo "=========================================="
echo "Acesse no navegador:"
echo "http://$SSH_HOST"
echo "=========================================="
echo ""
echo "NÃO use o file manager!"
echo "Use a URL do site diretamente!"

