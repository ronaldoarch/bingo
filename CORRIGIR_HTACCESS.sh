#!/bin/bash

# Script para corrigir .htaccess no servidor
# Execute este script NO SERVIDOR via SSH

echo "=========================================="
echo "Corrigindo .htaccess para React"
echo "=========================================="

cd ~/public_html

# Fazer backup
if [ -f ".htaccess" ]; then
    cp .htaccess .htaccess.backup
    echo "Backup criado: .htaccess.backup"
fi

# Criar novo .htaccess
cat > .htaccess << 'EOF'
DirectoryIndex index.html
Options -Indexes

# Habilitar rewrite engine para SPA
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  
  # Não reescrever arquivos e diretórios existentes
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  
  # Redirecionar tudo para index.html (React Router)
  RewriteRule . /index.html [L]
</IfModule>

# Headers para arquivos estáticos
<IfModule mod_headers.c>
  <FilesMatch "\.(js|css|json|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$">
    Header set Access-Control-Allow-Origin "*"
  </FilesMatch>
</IfModule>
EOF

chmod 644 .htaccess

echo "✓ .htaccess atualizado!"
echo ""
echo "Conteúdo do novo .htaccess:"
cat .htaccess
echo ""
echo "Teste acessando: http://212.85.6.24"

