# Makefile para facilitar o build e deploy

.PHONY: build build-linux run test clean deploy

# Build para o sistema atual
build:
	go build -o bingo-backend main.go

# Build para Linux (Hostinger)
build-linux:
	GOOS=linux GOARCH=amd64 go build -o bingo-backend main.go

# Executar localmente
run:
	go run main.go

# Executar testes
test:
	go test ./...

# Limpar arquivos compilados
clean:
	rm -f bingo-backend

# Instalar dependências
deps:
	go mod download
	go mod tidy

# Deploy (ajuste conforme necessário)
deploy: build-linux
	@echo "Build concluído! Arquivo: bingo-backend"
	@echo "Faça upload do arquivo e do .env para o servidor"

