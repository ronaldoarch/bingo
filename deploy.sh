#!/bin/bash

# Script de deploy para Hostinger
# Este script prepara os arquivos para deploy

echo "=========================================="
echo "Preparando deploy para Hostinger"
echo "=========================================="

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Build do Back-end
echo -e "${YELLOW}1. Compilando back-end...${NC}"
cd bingo-backend
GOOS=linux GOARCH=amd64 go build -o bingo-backend main.go
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Back-end compilado com sucesso!${NC}"
else
    echo "✗ Erro ao compilar back-end"
    exit 1
fi
cd ..

# 2. Build do Front-end
echo -e "${YELLOW}2. Compilando front-end...${NC}"
cd bingo-frontend
npm install
if [ $? -ne 0 ]; then
    echo "✗ Erro ao instalar dependências do front-end"
    exit 1
fi

npm run build
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Front-end compilado com sucesso!${NC}"
else
    echo "✗ Erro ao compilar front-end"
    exit 1
fi
cd ..

# 3. Criar diretório de deploy
echo -e "${YELLOW}3. Criando diretório de deploy...${NC}"
mkdir -p deploy
rm -rf deploy/*

# 4. Copiar arquivos do back-end
echo -e "${YELLOW}4. Copiando arquivos do back-end...${NC}"
cp bingo-backend/bingo-backend deploy/
cp bingo-backend/env.template deploy/backend.env.template
cp bingo-backend/database.sql deploy/

# 5. Copiar arquivos do front-end
echo -e "${YELLOW}5. Copiando arquivos do front-end...${NC}"
cp -r bingo-frontend/build deploy/frontend

# 6. Criar arquivo de instruções
cat > deploy/INSTRUCOES.txt << EOF
==========================================
INSTRUÇÕES DE DEPLOY NA HOSTINGER
==========================================

BACK-END:
1. Faça upload do arquivo 'bingo-backend' para o servidor
2. Copie 'backend.env.template' para '.env' e configure com suas credenciais
3. Dê permissão de execução: chmod +x bingo-backend
4. Execute: ./bingo-backend
   OU configure como serviço systemd (veja DEPLOY_HOSTINGER.md)

FRONT-END:
1. Faça upload do conteúdo da pasta 'frontend' para public_html/
2. Configure o servidor web (Apache/Nginx) conforme DEPLOY_HOSTINGER.md

BANCO DE DADOS:
1. Execute o script 'database.sql' no MySQL da Hostinger
2. Configure as credenciais no arquivo .env do back-end

Para mais detalhes, consulte DEPLOY_HOSTINGER.md
EOF

echo ""
echo -e "${GREEN}=========================================="
echo "Deploy preparado com sucesso!"
echo "==========================================${NC}"
echo ""
echo "Arquivos prontos na pasta 'deploy/':"
echo "  - bingo-backend (executável)"
echo "  - backend.env.template (configurações)"
echo "  - database.sql (script do banco)"
echo "  - frontend/ (arquivos do React)"
echo "  - INSTRUCOES.txt (instruções rápidas)"
echo ""
echo "Próximos passos:"
echo "1. Faça upload dos arquivos para a Hostinger"
echo "2. Configure o arquivo .env com suas credenciais"
echo "3. Execute o script database.sql no MySQL"
echo "4. Inicie o servidor back-end"
echo ""

