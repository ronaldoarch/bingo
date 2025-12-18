# Usar Railway para MySQL + Coolify para Aplicações

Railway oferece MySQL gerenciado de forma simples e confiável.

## 🗄️ Criar MySQL no Railway

### 1. Acessar Railway

1. Acesse: https://railway.app/
2. Faça login (pode usar GitHub)
3. Clique em **"New Project"**

### 2. Adicionar MySQL

1. Clique em **"New"** → **"Database"** → **"MySQL"**
2. Railway vai criar automaticamente:
   - Instância MySQL
   - Credenciais de acesso
   - Conexão configurada

### 3. Obter Credenciais

1. Clique no serviço MySQL criado
2. Vá em **"Variables"** ou **"Connect"**
3. Anote as seguintes informações:
   - `MYSQLHOST` (host)
   - `MYSQLPORT` (porta, geralmente 3306)
   - `MYSQLDATABASE` (nome do banco)
   - `MYSQLUSER` (usuário)
   - `MYSQLPASSWORD` (senha)

### 4. Criar Tabela no Railway

1. No Railway, vá em **"MySQL"** → **"Data"** ou **"Query"**
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

OU use o arquivo SQL:
1. Vá em **"MySQL"** → **"Data"** → **"Import"**
2. Faça upload do arquivo `bingo-backend/create_table.sql`

## 🔗 Conectar Coolify ao MySQL do Railway

### Configurar Back-end no Coolify

1. No Coolify, ao criar o back-end, use estas variáveis:

```
DB_USER=MYSQLUSER_do_Railway
DB_PASSWORD=MYSQLPASSWORD_do_Railway
DB_HOST=MYSQLHOST_do_Railway
DB_PORT=MYSQLPORT_do_Railway
DB_NAME=MYSQLDATABASE_do_Railway
PORT=8080
CORS_ORIGIN=https://seudominio.com
```

### Exemplo Real:

Se o Railway forneceu:
- Host: `containers-us-west-xxx.railway.app`
- Port: `3306`
- Database: `railway`
- User: `root`
- Password: `abc123xyz`

Configure no Coolify:
```
DB_USER=root
DB_PASSWORD=abc123xyz
DB_HOST=containers-us-west-xxx.railway.app
DB_PORT=3306
DB_NAME=railway
PORT=8080
CORS_ORIGIN=https://seudominio.com
```

## 🔒 Segurança

### Railway MySQL

- ✅ SSL/TLS automático
- ✅ Conexões seguras
- ✅ Backup automático
- ✅ Escalável

### Configurar SSL no Go

O Railway MySQL usa SSL. Atualize a conexão:

```go
// Em db/connection.go, adicione ?tls=true
connectionString := dbUser + ":" + dbPassword + "@tcp(" + dbHost + ":" + dbPort + ")/" + dbName + "?tls=true"
```

## 📊 Vantagens Railway MySQL

✅ Gerenciado (sem manutenção)
✅ SSL automático
✅ Backup automático
✅ Escalável
✅ Interface web para gerenciar dados
✅ Conexão externa permitida (para Coolify)

## 🔄 Alternativa: Railway para Tudo

Se preferir, pode fazer deploy completo no Railway:

1. **MySQL**: Railway (já configurado)
2. **Back-end Go**: Railway → New → GitHub → `bingo-backend`
3. **Front-end React**: Railway → New → GitHub → `bingo-frontend`

Railway suporta Dockerfiles automaticamente!

## 📝 Checklist

- [ ] Criar MySQL no Railway
- [ ] Anotar credenciais (host, port, user, password, database)
- [ ] Criar tabela `users` no Railway
- [ ] Configurar variáveis no Coolify com credenciais do Railway
- [ ] Testar conexão do back-end
- [ ] Verificar logs no Coolify

