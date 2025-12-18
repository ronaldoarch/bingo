# Guia Completo de Deploy no Coolify

[Coolify](https://coolify.io) é uma plataforma de deploy self-hosted que facilita muito o processo de deploy.

## 📋 Pré-requisitos

- Coolify instalado e rodando
- Acesso ao painel do Coolify (geralmente `http://seu-ip:8000`)
- Repositório GitHub: `https://github.com/ronaldoarch/bingo.git`

## 🚀 Passo a Passo

### 1. Criar Serviço MySQL

1. No Coolify, clique em **"New Resource"** → **"Database"** → **"MySQL"**
2. Configure:
   - **Name**: `bingo-mysql`
   - **Database Name**: `bingo`
   - **Root Password**: (gerar senha forte ou usar a gerada)
   - **User**: `bingo_user` (ou deixar padrão)
   - **Password**: (anotar esta senha!)
3. Clique em **"Deploy"**
4. Aguarde o MySQL estar rodando (status verde)

### 2. Criar Back-end Go

1. No Coolify, clique em **"New Resource"** → **"Application"** → **"GitHub"**
2. Configure:
   - **Repository**: `ronaldoarch/bingo`
   - **Branch**: `main`
   - **Base Directory**: `bingo-backend`
   - **Build Pack**: **Docker** (importante!)
   - **Port**: `8080`
   - **Dockerfile Path**: `bingo-backend/Dockerfile`
3. **Environment Variables**:
   ```
   DB_USER=bingo_user
   DB_PASSWORD=sua_senha_mysql_aqui
   DB_HOST=bingo-mysql
   DB_PORT=3306
   DB_NAME=bingo
   PORT=8080
   CORS_ORIGIN=https://seudominio.com
   ```
4. **Networks**: Conectar ao serviço `bingo-mysql`
5. Clique em **"Deploy"**

### 3. Criar Front-end React

1. No Coolify, clique em **"New Resource"** → **"Application"** → **"GitHub"**
2. Configure:
   - **Repository**: `ronaldoarch/bingo`
   - **Branch**: `main`
   - **Base Directory**: `bingo-frontend`
   - **Build Pack**: **Docker** (importante!)
   - **Port**: `80`
   - **Dockerfile Path**: `bingo-frontend/Dockerfile`
3. **Environment Variables**:
   ```
   REACT_APP_API_URL=https://api.seudominio.com
   ```
   (Substitua pela URL real do seu back-end)
4. **Networks**: Conectar ao serviço do back-end
5. Clique em **"Deploy"**

### 4. Configurar Banco de Dados

Após o MySQL estar rodando:

1. No Coolify, clique no serviço `bingo-mysql`
2. Vá em **"Terminal"** ou **"Database"** → **"phpMyAdmin"**
3. Execute o SQL:

```sql
USE bingo;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu');
```

### 5. Configurar Domínios e SSL

1. **Back-end API**:
   - No serviço do back-end, vá em **"Domains"**
   - Adicione: `api.seudominio.com`
   - Ative **SSL** (Let's Encrypt automático)

2. **Front-end**:
   - No serviço do front-end, vá em **"Domains"**
   - Adicione: `seudominio.com`
   - Ative **SSL** (Let's Encrypt automático)

3. **Atualizar CORS**:
   - No back-end, atualize a variável `CORS_ORIGIN`:
     ```
     CORS_ORIGIN=https://seudominio.com
     ```
   - Reinicie o back-end

### 6. Atualizar Front-end com URL Correta

1. No serviço do front-end, vá em **"Environment Variables"**
2. Atualize:
   ```
   REACT_APP_API_URL=https://api.seudominio.com
   ```
3. Faça **"Redeploy"** do front-end

## 🔧 Configurações Avançadas

### Health Checks

O Coolify pode configurar health checks automaticamente. Verifique:
- Back-end: `http://localhost:8080/login` (deve retornar 405 Method Not Allowed, o que é normal)
- Front-end: `http://localhost/` (deve retornar 200 OK)

### Volumes Persistentes

O MySQL já cria volumes automaticamente. Para o back-end, se precisar de logs persistentes:

1. Vá em **"Volumes"** do serviço back-end
2. Adicione: `/app/logs` → `/var/log/bingo`

### Variáveis de Ambiente Sensíveis

Use **"Secrets"** do Coolify para senhas:
1. Vá em **"Secrets"**
2. Crie secrets para senhas do MySQL
3. Use nos environment variables: `DB_PASSWORD={{secrets.mysql_password}}`

## 📝 Estrutura Final no Coolify

```
Coolify Dashboard
├── bingo-mysql (Database)
│   └── Port: 3306 (interno)
│
├── bingo-backend (Application)
│   └── Port: 8080
│   └── Domain: api.seudominio.com
│   └── Network: Conectado ao bingo-mysql
│
└── bingo-frontend (Application)
    └── Port: 80
    └── Domain: seudominio.com
    └── Network: Conectado ao bingo-backend
```

## ✅ Verificação Final

1. **Back-end funcionando**:
   ```bash
   curl https://api.seudominio.com/login -X POST \
     -H "Content-Type: application/json" \
     -d '{"username":"user1","password":"password"}'
   ```

2. **Front-end funcionando**:
   - Acesse: `https://seudominio.com`
   - Deve carregar a página de login

3. **Login funcionando**:
   - Usuário: `user1`
   - Senha: `password`

## 🐛 Troubleshooting

### Back-end não conecta ao MySQL

- Verifique se o `DB_HOST` está como `bingo-mysql` (nome do serviço)
- Verifique se os serviços estão na mesma rede
- Verifique as credenciais do MySQL

### Front-end não conecta ao Back-end

- Verifique se `REACT_APP_API_URL` está correto
- Verifique se o CORS está configurado corretamente
- Verifique os logs do back-end no Coolify

### Erro 502 Bad Gateway

- Verifique se os serviços estão rodando
- Verifique os logs no Coolify
- Verifique se as portas estão corretas

## 📚 Recursos

- [Documentação Coolify](https://coolify.io/docs)
- [Coolify GitHub](https://github.com/coollabsio/coolify)

