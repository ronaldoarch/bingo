# Guia Rápido de Deploy na Hostinger

## 🚀 Deploy Rápido (5 minutos)

### 1. Preparar os arquivos localmente

```bash
# Execute o script de deploy
./deploy.sh
```

Isso criará uma pasta `deploy/` com todos os arquivos necessários.

### 2. Configurar o Banco de Dados MySQL

1. Acesse o painel da Hostinger → **MySQL Databases**
2. Crie um banco de dados chamado `bingo`
3. Anote: usuário, senha, host
4. Execute o SQL:
   ```sql
   CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

### 3. Fazer Upload do Back-end

**Via SSH (VPS):**
```bash
# Upload do executável
scp deploy/bingo-backend usuario@ip:/home/usuario/

# Conectar e configurar
ssh usuario@ip
chmod +x bingo-backend
nano .env  # Configure com credenciais do MySQL
```

**Via FTP:**
- Faça upload de `bingo-backend` e `backend.env.template`
- Renomeie `backend.env.template` para `.env` e configure

**Configurar .env:**
```bash
DB_USER=seu_usuario_mysql
DB_PASSWORD=sua_senha_mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=bingo
PORT=8080
```

### 4. Iniciar o Back-end

**Opção A: Execução direta**
```bash
./bingo-backend
```

**Opção B: Como serviço (recomendado)**
```bash
sudo nano /etc/systemd/system/bingo.service
```

Cole:
```ini
[Unit]
Description=Bingo Backend
After=network.target

[Service]
Type=simple
User=seu_usuario
WorkingDirectory=/home/seu_usuario
EnvironmentFile=/home/seu_usuario/.env
ExecStart=/home/seu_usuario/bingo-backend
Restart=always

[Install]
WantedBy=multi-user.target
```

Ativar:
```bash
sudo systemctl enable bingo
sudo systemctl start bingo
```

### 5. Fazer Upload do Front-end

**Via FTP ou File Manager:**
1. Faça upload do conteúdo de `deploy/frontend/` para `public_html/`
2. Ou para um subdiretório se preferir

### 6. Configurar Variáveis de Ambiente do Front-end

Antes de fazer build, configure:

```bash
cd bingo-frontend
echo "REACT_APP_API_URL=https://api.seudominio.com" > .env.production
npm run build
```

Ou edite manualmente o arquivo `.env.production` com a URL do seu back-end.

### 7. Configurar Proxy Reverso (Nginx) - Opcional

Se você tem acesso ao Nginx:

```nginx
# Para API
server {
    listen 80;
    server_name api.seudominio.com;
    location / {
        proxy_pass http://localhost:8080;
    }
}

# Para Front-end
server {
    listen 80;
    server_name seudominio.com;
    root /home/usuario/public_html;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 8. Ativar SSL

1. Painel Hostinger → SSL/TLS
2. Ativar certificado Let's Encrypt
3. Configurar redirecionamento HTTP → HTTPS

### 9. Testar

1. Acesse: `https://seudominio.com`
2. Tente fazer login com:
   - Usuário: `user1`
   - Senha: `password`

## ⚠️ Checklist de Deploy

- [ ] Banco de dados MySQL criado
- [ ] Tabela `users` criada
- [ ] Arquivo `.env` configurado no servidor
- [ ] Back-end compilado e enviado
- [ ] Back-end rodando (verificar: `systemctl status bingo`)
- [ ] Front-end compilado com URL correta da API
- [ ] Front-end enviado para `public_html/`
- [ ] SSL ativado
- [ ] CORS configurado corretamente
- [ ] Teste de login funcionando

## 🔧 Troubleshooting Rápido

**Back-end não inicia:**
```bash
# Ver logs
journalctl -u bingo -f

# Verificar permissões
chmod +x bingo-backend

# Testar manualmente
./bingo-backend
```

**Erro de conexão MySQL:**
```bash
# Testar conexão
mysql -u usuario -p -h host bingo

# Verificar .env
cat .env
```

**Front-end não carrega:**
- Verificar se arquivos estão em `public_html/`
- Verificar console do navegador (F12)
- Verificar se API está acessível

**CORS errors:**
- Atualizar `Access-Control-Allow-Origin` em `main.go`
- Recompilar e fazer upload novamente

## 📞 Suporte

Para mais detalhes, consulte `DEPLOY_HOSTINGER.md`

