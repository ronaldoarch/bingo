# Deploy no Seu Servidor Hostinger

## 🔐 Credenciais SSH

- **IP:** `212.85.6.24`
- **Porta:** `65002`
- **Usuário:** `u127271520`
- **Comando SSH:** `ssh -p 65002 u127271520@212.85.6.24`

## 📋 Passo a Passo do Deploy

### 1. Preparar Arquivos Localmente

```bash
# No diretório do projeto
cd /Users/ronaldodiasdesousa/Desktop/Bingo

# Executar script de deploy
./deploy.sh
```

### 2. Conectar ao Servidor via SSH

```bash
ssh -p 65002 u127271520@212.85.6.24
```

Quando solicitado, digite sua senha SSH.

### 3. Criar Estrutura de Diretórios no Servidor

Após conectar, execute:

```bash
# Criar diretório para o back-end
mkdir -p ~/bingo-backend

# Criar diretório para o front-end (se necessário)
mkdir -p ~/public_html/bingo
```

### 4. Fazer Upload do Back-end

**No seu computador local (novo terminal):**

```bash
# Navegar para a pasta deploy
cd /Users/ronaldodiasdesousa/Desktop/Bingo/deploy

# Fazer upload do executável
scp -P 65002 bingo-backend u127271520@212.85.6.24:~/bingo-backend/

# Fazer upload do template de configuração
scp -P 65002 backend.env.template u127271520@212.85.6.24:~/bingo-backend/.env.template
```

### 5. Configurar o Back-end no Servidor

**Conecte novamente via SSH e execute:**

```bash
# Navegar para o diretório
cd ~/bingo-backend

# Dar permissão de execução
chmod +x bingo-backend

# Criar arquivo .env
nano .env
```

Cole as seguintes configurações (ajuste com suas credenciais do MySQL):

```bash
DB_USER=seu_usuario_mysql
DB_PASSWORD=sua_senha_mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=bingo
PORT=8080
```

Salve com `Ctrl+X`, depois `Y`, depois `Enter`.

### 6. Configurar Banco de Dados MySQL

1. Acesse o painel da Hostinger
2. Vá em **MySQL Databases**
3. Crie o banco `bingo` (se ainda não existir)
4. Anote as credenciais (usuário, senha, host)
5. Execute o SQL:

```sql
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**OU faça upload do arquivo SQL:**

```bash
# No seu computador local
scp -P 65002 database.sql u127271520@212.85.6.24:~/

# No servidor, execute:
mysql -u seu_usuario_mysql -p bingo < ~/database.sql
```

### 7. Testar o Back-end

```bash
# No servidor
cd ~/bingo-backend
./bingo-backend
```

Se funcionar, pressione `Ctrl+C` para parar. Agora vamos configurar como serviço.

### 8. Configurar como Serviço (Systemd)

```bash
# Criar arquivo de serviço
sudo nano /etc/systemd/system/bingo-backend.service
```

Cole o seguinte conteúdo:

```ini
[Unit]
Description=Bingo Backend Service
After=network.target

[Service]
Type=simple
User=u127271520
WorkingDirectory=/home/u127271520/bingo-backend
EnvironmentFile=/home/u127271520/bingo-backend/.env
ExecStart=/home/u127271520/bingo-backend/bingo-backend
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Ativar e iniciar o serviço:

```bash
sudo systemctl daemon-reload
sudo systemctl enable bingo-backend
sudo systemctl start bingo-backend
sudo systemctl status bingo-backend
```

### 9. Configurar Front-end

**No seu computador local:**

```bash
cd /Users/ronaldodiasdesousa/Desktop/Bingo/bingo-frontend

# Criar arquivo .env.production com a URL da API
# IMPORTANTE: Substitua pela URL real do seu back-end
echo "REACT_APP_API_URL=http://212.85.6.24:8080" > .env.production

# OU se você configurou um domínio:
# echo "REACT_APP_API_URL=https://api.seudominio.com" > .env.production

# Fazer build
npm run build
```

**Fazer upload do front-end:**

```bash
# Upload da pasta build
scp -P 65002 -r build/* u127271520@212.85.6.24:~/public_html/
```

### 10. Configurar Proxy Reverso (Opcional mas Recomendado)

Se você tem acesso ao Nginx ou Apache, configure um proxy reverso para acessar a API via porta 80/443.

**Para Nginx:**

```bash
sudo nano /etc/nginx/sites-available/bingo-api
```

```nginx
server {
    listen 80;
    server_name api.seudominio.com;  # ou seu IP

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Ativar:
```bash
sudo ln -s /etc/nginx/sites-available/bingo-api /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 11. Verificar e Testar

**Testar o back-end:**
```bash
curl http://localhost:8080/login -X POST \
  -H "Content-Type: application/json" \
  -d '{"username":"user1","password":"password"}'
```

**Testar o front-end:**
- Acesse `http://212.85.6.24` ou seu domínio
- Tente fazer login

## 🔧 Comandos Úteis

**Ver logs do serviço:**
```bash
sudo journalctl -u bingo-backend -f
```

**Reiniciar serviço:**
```bash
sudo systemctl restart bingo-backend
```

**Verificar se está rodando:**
```bash
sudo systemctl status bingo-backend
ps aux | grep bingo-backend
```

**Verificar porta:**
```bash
netstat -tulpn | grep 8080
```

## ⚠️ Troubleshooting

**Back-end não inicia:**
- Verifique o arquivo `.env`: `cat ~/bingo-backend/.env`
- Verifique permissões: `chmod +x ~/bingo-backend/bingo-backend`
- Veja os logs: `sudo journalctl -u bingo-backend -n 50`

**Erro de conexão MySQL:**
- Teste a conexão: `mysql -u usuario -p -h host bingo`
- Verifique se o MySQL está rodando: `sudo systemctl status mysql`

**Front-end não carrega:**
- Verifique se os arquivos estão em `~/public_html/`
- Verifique permissões: `chmod -R 755 ~/public_html/`

**CORS errors:**
- Atualize o CORS em `main.go` com o domínio/IP correto
- Recompile e faça upload novamente

## 📝 Checklist Final

- [ ] Back-end compilado e enviado
- [ ] Arquivo `.env` configurado no servidor
- [ ] Banco de dados MySQL criado e tabela `users` criada
- [ ] Serviço systemd configurado e rodando
- [ ] Front-end compilado com URL correta da API
- [ ] Front-end enviado para `public_html/`
- [ ] Teste de login funcionando
- [ ] SSL configurado (se usando domínio)

## 🎯 Próximos Passos

1. Configurar domínio personalizado (se tiver)
2. Ativar SSL/HTTPS
3. Configurar backup automático do banco de dados
4. Adicionar monitoramento e logs

