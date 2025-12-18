#!/bin/bash

# Script de build para produção na Hostinger
# Este script compila o aplicativo Go para Linux

echo "Construindo aplicativo Go para produção..."

# Definir variáveis
GOOS=linux
GOARCH=amd64

# Compilar o aplicativo
go build -o bingo-backend main.go

echo "Build concluído! Arquivo gerado: bingo-backend"
echo "Certifique-se de configurar as variáveis de ambiente no servidor."

