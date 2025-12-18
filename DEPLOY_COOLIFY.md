# Guia de Deploy no Coolify

[Coolify](https://coolify.io) é uma plataforma de deploy self-hosted que facilita muito o processo de deploy de aplicações.

## Pré-requisitos

- Coolify instalado e rodando
- Acesso ao painel do Coolify
- Domínio configurado (opcional)

## Estrutura do Deploy

Vamos criar 3 serviços no Coolify:
1. **MySQL** - Banco de dados
2. **Back-end Go** - API REST
3. **Front-end React** - Interface web

## Passo 1: Criar Serviço MySQL

1. No Coolify, clique em **"New Resource"** → **"Database"** → **"MySQL"**
2. Configure:
   - **Name**: `bingo-mysql`
   - **Database Name**: `bingo`
   - **Root Password**: (gerar senha forte)
   - **User**: `bingo_user`
   - **Password**: (gerar senha forte)
3. Clique em **"Deploy"**

## Passo 2: Criar Back-end Go

### Opção A: Deploy via Dockerfile (Recomendado)

1. Criar `Dockerfile` no diretório `bingo-backend/`
2. No Coolify:
   - **New Resource** → **Application** → **GitHub**
   - Selecione o repositório: `ronaldoarch/bingo`
   - **Base Directory**: `bingo-backend`
   - **Build Pack**: Docker
   - **Port**: `8080`
   - **Environment Variables**:
     ```
     DB_USER=bingo_user
     DB_PASSWORD=sua_senha_mysql
     DB_HOST=bingo-mysql
     DB_PORT=3306
     DB_NAME=bingo
     PORT=8080
     ```
   - **Network**: Conectar ao serviço `bingo-mysql`
   - Clique em **"Deploy"**

### Opção B: Deploy via Docker Compose

Criar arquivo `docker-compose.yml` na raiz do projeto.

## Passo 3: Criar Front-end React

1. No Coolify:
   - **New Resource** → **Application** → **GitHub**
   - Selecione o repositório: `ronaldoarch/bingo`
   - **Base Directory**: `bingo-frontend`
   - **Build Pack**: Nixpacks (React)
   - **Port**: `3000` (ou deixar padrão)
   - **Environment Variables**:
     ```
     REACT_APP_API_URL=https://api.seudominio.com
     ```
   - **Network**: Conectar ao serviço do back-end
   - Clique em **"Deploy"**

## Passo 4: Configurar Banco de Dados

Após o MySQL estar rodando:

1. Acesse o terminal do MySQL no Coolify
2. Execute o SQL:

```sql
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu');
```

## Passo 5: Configurar Domínios

1. **Back-end API**:
   - Domínio: `api.seudominio.com`
   - SSL: Ativar (Let's Encrypt automático)

2. **Front-end**:
   - Domínio: `seudominio.com`
   - SSL: Ativar (Let's Encrypt automático)

## Passo 6: Configurar CORS

Atualizar o CORS no back-end para aceitar o domínio do front-end.

## Arquivos Necessários

Vou criar os arquivos Docker necessários para o Coolify.

