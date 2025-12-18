#!/bin/bash

# Script para testar acesso ao site

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"

echo "=========================================="
echo "Testando Acesso ao Site"
echo "=========================================="
echo ""

echo "1. Testando acesso HTTP direto:"
curl -I http://$SSH_HOST/ 2>&1 | head -10

echo ""
echo "2. Testando index.html:"
curl -I http://$SSH_HOST/index.html 2>&1 | head -10

echo ""
echo "3. Verificando conteúdo do index.html:"
echo "Execute no servidor: cat ~/public_html/index.html | head -20"

echo ""
echo "4. Verificando .htaccess:"
echo "Execute no servidor: cat ~/public_html/.htaccess"

echo ""
echo "=========================================="
echo "Acesse no navegador:"
echo "http://$SSH_HOST"
echo "=========================================="

