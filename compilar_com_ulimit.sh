#!/bin/bash

# Script para compilar no servidor com ulimit ajustado
# Execute este script NO SERVIDOR após fazer upload do código

echo "=========================================="
echo "Compilando com ulimit ajustado"
echo "=========================================="

cd ~/bingo-backend

# Verificar limite atual
echo "Limite atual de processos: $(ulimit -u)"

# Aumentar limite
ulimit -u 4096
echo "Novo limite: $(ulimit -u)"

# Configurar variáveis
export GOSUMDB=off
export GOMAXPROCS=2

# Remover go.sum problemático
rm -f go.sum

# Limpar cache
go clean -modcache 2>/dev/null || true

# Gerar novo go.sum
go mod tidy

# Compilar com menos threads se necessário
echo "Compilando..."
go build -o bingo-backend main.go

if [ -f "bingo-backend" ]; then
    chmod +x bingo-backend
    echo "✓ Compilação concluída com sucesso!"
    ls -lh bingo-backend
else
    echo "✗ Erro na compilação"
    echo "Tente: GOMAXPROCS=1 go build -o bingo-backend main.go"
fi

