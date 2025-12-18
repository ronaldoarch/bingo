# Dockerfile para Back-end Go
FROM golang:1.21-alpine AS builder

# Instalar dependências do sistema
RUN apk add --no-cache git

# Definir diretório de trabalho
WORKDIR /app

# Copiar go.mod e go.sum
COPY go.mod go.sum ./

# Baixar dependências
RUN go mod download

# Copiar código fonte
COPY . .

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

