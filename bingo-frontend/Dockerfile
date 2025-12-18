# Dockerfile para Front-end React
FROM node:18-alpine AS builder

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências
RUN npm install --legacy-peer-deps

# Copiar código fonte
COPY . .

# Build da aplicação
RUN npm run build

# Imagem final com Nginx
FROM nginx:alpine

# Copiar build para Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Copiar configuração customizada do Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expor porta
EXPOSE 80

# Comando para executar
CMD ["nginx", "-g", "daemon off;"]

