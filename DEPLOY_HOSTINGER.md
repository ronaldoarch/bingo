# Guia de Deploy na Hostinger

Este guia explica como fazer o deploy do sistema de login Bingo VIP na Hostinger.

## Opções de Deploy na Hostinger

A Hostinger oferece diferentes tipos de hospedagem. Para este projeto, você tem duas opções principais:

### Opção 1: Hospedagem Compartilhada (VPS/Cloud)
- Front-end: Hospedagem estática (React build)
- Back-end: VPS com Go
- Banco de Dados: MySQL incluído

### Opção 2: Hospedagem VPS Dedicado
- Mais controle sobre o ambiente
- Pode rodar Go diretamente
- MySQL já incluído

## Pré-requisitos

1. Conta na Hostinger
2. Acesso SSH (para VPS) ou FTP (para hospedagem compartilhada)
3. Banco de dados MySQL criado no painel da Hostinger
4. Domínio configurado (opcional, mas recomendado)

## Passo a Passo

### 1. Preparar o Banco de Dados MySQL

1. Acesse o painel de controle da Hostinger
2. Vá em **MySQL Databases**
3. Crie um novo banco de dados chamado `bingo`
4. Crie um usuário e anote as credenciais:
   - Host (geralmente `localhost` ou um IP específico)
   - Usuário
   - Senha
   - Nome do banco

5. Execute o script SQL no banco de dados:
   ```sql
   CREATE TABLE IF NOT EXISTS users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255) NOT NULL UNIQUE,
       password VARCHAR(255) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

### 2. Preparar o Back-end (Go)

#### 2.1. Compilar o aplicativo localmente

No seu computador, execute:

```bash
cd bingo-backend

# Para Linux (Hostinger geralmente usa Linux)
GOOS=linux GOARCH=amd64 go build -o bingo-backend main.go

# Ou use o script fornecido
chmod +x build.sh
./build.sh
```

#### 2.2. Criar arquivo de configuração

Crie um arquivo `.env` no servidor com as credenciais do banco:

```bash
DB_USER=seu_usuario_mysql
DB_PASSWORD=sua_senha_mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=bingo
PORT=8080
```

#### 2.3. Fazer upload dos arquivos

**Para VPS:**
```bash
# Via SCP
scp bingo-backend seu_usuario@seu_ip:/home/seu_usuario/

# Ou via FTP/SFTP
# Faça upload do arquivo compilado e do .env
```

**Para Hospedagem Compartilhada:**
- Use o File Manager ou FTP para fazer upload

#### 2.4. Configurar o servidor

**No servidor VPS:**

```bash
# Conectar via SSH
ssh seu_usuario@seu_ip

# Dar permissão de execução
chmod +x bingo-backend

# Criar arquivo .env com as configurações
nano .env
# Cole as configurações do banco de dados

# Testar execução
./bingo-backend
```

#### 2.5. Configurar como serviço (Systemd) - Recomendado

Crie um arquivo de serviço:

```bash
sudo nano /etc/systemd/system/bingo-backend.service
```

Conteúdo:

```ini
[Unit]
Description=Bingo Backend Service
After=network.target

[Service]
Type=simple
User=seu_usuario
WorkingDirectory=/home/seu_usuario
EnvironmentFile=/home/seu_usuario/.env
ExecStart=/home/seu_usuario/bingo-backend
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Ativar o serviço:

```bash
sudo systemctl daemon-reload
sudo systemctl enable bingo-backend
sudo systemctl start bingo-backend
sudo systemctl status bingo-backend
```

#### 2.6. Configurar Proxy Reverso (Nginx)

Se você tem acesso ao Nginx, configure um proxy reverso:

```nginx
server {
    listen 80;
    server_name api.seudominio.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 3. Preparar o Front-end (React)

#### 3.1. Criar arquivo .env para produção

Crie um arquivo `.env.production`:

```bash
REACT_APP_API_URL=https://api.seudominio.com
# ou
REACT_APP_API_URL=https://seudominio.com/api
```

#### 3.2. Fazer build do React

```bash
cd bingo-frontend

# Instalar dependências
npm install

# Criar build de produção
npm run build
```

Isso criará uma pasta `build/` com os arquivos estáticos.

#### 3.3. Fazer upload do build

**Opção A: Hospedagem Estática (Recomendado)**
- Faça upload da pasta `build/` para o diretório `public_html/` ou `www/`
- Renomeie `build` para o nome desejado (ex: `app`)

**Opção B: Subdiretório**
- Se o front-end estiver em um subdiretório, ajuste o `package.json`:
  ```json
  "homepage": "/caminho-do-subdiretorio"
  ```

#### 3.4. Configurar o servidor web

**Para Apache (.htaccess):**
```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>
```

**Para Nginx:**
```nginx
server {
    listen 80;
    server_name seudominio.com;
    root /home/seu_usuario/public_html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 4. Configurar CORS no Back-end

Se o front-end e back-end estiverem em domínios diferentes, atualize o CORS em `main.go`:

```go
func corsMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        // Substitua pelo seu domínio
        w.Header().Set("Access-Control-Allow-Origin", "https://seudominio.com")
        w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
        w.Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")

        if r.Method == "OPTIONS" {
            w.WriteHeader(http.StatusOK)
            return
        }

        next.ServeHTTP(w, r)
    })
}
```

### 5. Configurar SSL/HTTPS

A Hostinger geralmente oferece SSL gratuito via Let's Encrypt:

1. Acesse o painel de controle
2. Vá em **SSL/TLS**
3. Ative o certificado SSL para seu domínio
4. Configure redirecionamento HTTP para HTTPS

### 6. Verificar e Testar

1. **Testar o back-end:**
   ```bash
   curl https://api.seudominio.com/login -X POST \
     -H "Content-Type: application/json" \
     -d '{"username":"user1","password":"password"}'
   ```

2. **Testar o front-end:**
   - Acesse `https://seudominio.com`
   - Tente fazer login

## Estrutura de Arquivos no Servidor

```
/home/seu_usuario/
├── bingo-backend          # Executável compilado
├── .env                   # Configurações do back-end
└── public_html/           # Front-end React
    ├── index.html
    ├── static/
    └── ...
```

## Troubleshooting

### Back-end não inicia
- Verifique as permissões: `chmod +x bingo-backend`
- Verifique as variáveis de ambiente: `cat .env`
- Verifique os logs: `journalctl -u bingo-backend -f`

### Erro de conexão com banco de dados
- Verifique se o MySQL está rodando
- Confirme as credenciais no `.env`
- Teste a conexão: `mysql -u usuario -p -h host bingo`

### Front-end não carrega
- Verifique se os arquivos estão em `public_html/`
- Verifique as permissões dos arquivos
- Verifique o console do navegador para erros

### CORS errors
- Verifique se o domínio no CORS está correto
- Certifique-se de que o protocolo (http/https) está correto

## Suporte

Para mais informações sobre a Hostinger:
- Documentação: https://www.hostinger.com.br/tutoriais
- Suporte: Através do painel de controle

## Notas Importantes

1. **Segurança:**
   - Nunca commite arquivos `.env` no Git
   - Use senhas fortes para o banco de dados
   - Mantenha o SSL ativado

2. **Performance:**
   - Configure cache no servidor web
   - Use CDN para assets estáticos (opcional)

3. **Backup:**
   - Faça backup regular do banco de dados
   - Mantenha backups dos arquivos de configuração

