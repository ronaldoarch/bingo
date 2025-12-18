#!/bin/bash

# Script para compilar no servidor resolvendo problemas de permissão
# Execute este script NO SERVIDOR após fazer upload do código

echo "=========================================="
echo "Compilando Back-end no Servidor"
echo "=========================================="

cd ~/bingo-backend

# Solução 1: Configurar GOPATH local
echo "Configurando GOPATH local..."
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
mkdir -p $GOPATH

# Solução 2: Desabilitar verificação de sumdb temporariamente
export GOSUMDB=off

# Limpar cache problemático
echo "Limpando cache..."
go clean -modcache 2>/dev/null || true

# Tentar baixar dependências
echo "Baixando dependências..."
go mod download 2>&1 | grep -v "permission denied" || true

# Se ainda houver problemas, tentar go get
echo "Instalando dependências..."
go get github.com/gorilla/mux 2>/dev/null || true
go get github.com/go-sql-driver/mysql 2>/dev/null || true
go get golang.org/x/crypto/bcrypt 2>/dev/null || true

# Compilar
echo "Compilando..."
go build -o bingo-backend main.go

if [ -f "bingo-backend" ]; then
    chmod +x bingo-backend
    echo "✓ Compilação concluída com sucesso!"
    echo "Arquivo: ~/bingo-backend/bingo-backend"
else
    echo "✗ Erro na compilação"
    echo "Tente executar manualmente:"
    echo "  export GOSUMDB=off"
    echo "  go build -o bingo-backend main.go"
fi

