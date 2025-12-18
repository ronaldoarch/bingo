# Dockerfile para Back-end Go
FROM golang:1.21-alpine AS builder

# Instalar dependências do sistema
RUN apk add --no-cache git

# Definir diretório de trabalho
WORKDIR /app

# Copiar go.mod primeiro (para cache de dependências)
COPY go.mod ./

# Copiar código fonte (necessário para go mod tidy resolver dependências)
COPY . .

# Gerar go.sum e baixar dependências
RUN go mod tidy && go mod download

# Compilar aplicação
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bingo-backend main.go

# Imagem final
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiar binário compilado
COPY --from=builder /app/bingo-backend .

# Expor porta
EXPOSE 8080

# Comando para executar
CMD ["./bingo-backend"]

