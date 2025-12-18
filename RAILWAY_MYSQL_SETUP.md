# Guia Rápido: MySQL no Railway + Coolify

## 🚀 Passo a Passo Rápido

### 1. Criar MySQL no Railway (2 minutos)

1. Acesse: https://railway.app/
2. Login com GitHub
3. **New Project** → **New** → **Database** → **MySQL**
4. Railway cria automaticamente! ✅

### 2. Obter Credenciais (1 minuto)

1. Clique no serviço MySQL
2. Vá em **"Variables"** ou **"Connect"**
3. Copie estas variáveis:
   - `MYSQLHOST`
   - `MYSQLPORT` 
   - `MYSQLDATABASE`
   - `MYSQLUSER`
   - `MYSQLPASSWORD`

### 3. Criar Tabela (1 minuto)

1. No Railway, vá em **MySQL** → **"Data"** → **"Query"**
2. Cole e execute:

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu');
```

### 4. Configurar no Coolify (Back-end)

Ao criar o back-end no Coolify, use estas variáveis:

```
DB_USER=[MYSQLUSER do Railway]
DB_PASSWORD=[MYSQLPASSWORD do Railway]
DB_HOST=[MYSQLHOST do Railway]
DB_PORT=[MYSQLPORT do Railway]
DB_NAME=[MYSQLDATABASE do Railway]
DB_USE_SSL=true
PORT=8080
CORS_ORIGIN=https://seudominio.com
```

## ✅ Vantagens

- ✅ MySQL gerenciado (sem manutenção)
- ✅ SSL automático
- ✅ Backup automático
- ✅ Interface web para gerenciar dados
- ✅ Conexão externa permitida
- ✅ Grátis para começar (com limites)

## 🔗 Exemplo de Configuração

Se o Railway forneceu:
```
MYSQLHOST=containers-us-west-123.railway.app
MYSQLPORT=3306
MYSQLDATABASE=railway
MYSQLUSER=root
MYSQLPASSWORD=abc123xyz789
```

Configure no Coolify:
```
DB_USER=root
DB_PASSWORD=abc123xyz789
DB_HOST=containers-us-west-123.railway.app
DB_PORT=3306
DB_NAME=railway
DB_USE_SSL=true
PORT=8080
```

## 📝 Próximos Passos

1. ✅ MySQL criado no Railway
2. ✅ Tabela criada
3. ✅ Back-end configurado no Coolify com credenciais do Railway
4. ✅ Front-end configurado no Coolify
5. ✅ Testar login!

