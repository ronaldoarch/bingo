# Solução para Problemas de Permissão no Servidor

Você está enfrentando problemas de permissão ao compilar no servidor. Execute estes comandos:

## Solução 1: Usar GOPATH local (Recomendado)

```bash
# No servidor, execute:
cd ~/bingo-backend

# Configurar GOPATH local
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
mkdir -p $GOPATH

# Limpar cache problemático
go clean -modcache

# Tentar novamente com módulos locais
go mod tidy
go mod download
go build -o bingo-backend main.go
chmod +x bingo-backend
```

## Solução 2: Compilar sem cache (Alternativa)

```bash
cd ~/bingo-backend

# Desabilitar verificação de sumdb temporariamente
export GOSUMDB=off

# Baixar dependências
go mod download

# Compilar
go build -o bingo-backend main.go
chmod +x bingo-backend
```

## Solução 3: Usar go get diretamente

```bash
cd ~/bingo-backend

# Instalar dependências manualmente
go get github.com/gorilla/mux
go get github.com/go-sql-driver/mysql
go get golang.org/x/crypto/bcrypt

# Compilar
go build -o bingo-backend main.go
chmod +x bingo-backend
```

## Solução 4: Compilar localmente e fazer upload (Mais fácil)

Se as soluções acima não funcionarem, compile no seu computador Mac usando Docker ou compile em outro lugar e faça upload apenas do executável.

