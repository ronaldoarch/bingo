#!/bin/bash

# Script para verificar e corrigir problemas de 403

SSH_USER="u127271520"
SSH_HOST="212.85.6.24"
SSH_PORT="65002"

echo "=========================================="
echo "Verificando Configuração do Servidor"
echo "=========================================="
echo ""
echo "Execute no servidor via SSH:"
echo ""
echo "ssh -p $SSH_PORT $SSH_USER@$SSH_HOST"
echo ""
echo "Depois execute:"
echo ""
echo "cd ~/public_html"
echo "ls -la"
echo "pwd"
echo ""
echo "Verificar permissões:"
echo "chmod 755 ~/public_html"
echo "chmod 644 ~/public_html/*"
echo "find ~/public_html -type d -exec chmod 755 {} \;"
echo "find ~/public_html -type f -exec chmod 644 {} \;"
echo ""

