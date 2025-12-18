#!/bin/bash

# Script para criar usuários no banco de dados em produção
# Uso: ./create_user_production.sh <username> <password>

if [ $# -lt 2 ]; then
    echo "Uso: $0 <username> <password>"
    exit 1
fi

USERNAME=$1
PASSWORD=$2

# Carregar variáveis de ambiente
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Erro: Arquivo .env não encontrado!"
    exit 1
fi

# Gerar hash da senha usando Go
HASH=$(go run -ldflags="-s -w" << 'EOF'
package main

import (
	"fmt"
	"os"
	"bingo-backend/utils"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "Erro: senha não fornecida\n")
		os.Exit(1)
	}
	hash, err := utils.GeneratePasswordHash(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Erro: %v\n", err)
		os.Exit(1)
	}
	fmt.Print(hash)
}
EOF "$PASSWORD")

if [ $? -ne 0 ]; then
    echo "Erro ao gerar hash da senha"
    exit 1
fi

# Inserir no banco de dados
mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" << EOF
INSERT INTO users (username, password) VALUES ('$USERNAME', '$HASH');
SELECT 'Usuário criado com sucesso!' AS resultado;
EOF

if [ $? -eq 0 ]; then
    echo "Usuário '$USERNAME' criado com sucesso!"
else
    echo "Erro ao criar usuário"
    exit 1
fi

