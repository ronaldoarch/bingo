# Guia de Deploy em VPS

## Vantagens da VPS

✅ Controle total sobre o servidor
✅ Sem limitações de permissões
✅ Pode instalar Go, Node.js, Nginx, etc.
✅ Melhor performance
✅ Sem problemas de "Proteção de Diretório"
✅ Pode configurar SSL facilmente

## Pré-requisitos

- VPS com Ubuntu/Debian (recomendado)
- Acesso root ou sudo
- IP público da VPS
- Porta 80 e 443 liberadas no firewall

## Passo a Passo

### 1. Conectar à VPS

```bash
ssh root@seu_ip_vps
# ou
ssh usuario@seu_ip_vps
```

### 2. Atualizar o Sistema

```bash
apt update && apt upgrade -y
```

### 3. Instalar Dependências

```bash
# Instalar Go
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
go version

# Instalar MySQL
apt install mysql-server -y
mysql_secure_installation

# Instalar Nginx
apt install nginx -y
systemctl start nginx
systemctl enable nginx
```

### 4. Configurar Banco de Dados MySQL

```bash
mysql -u root -p
```

```sql
CREATE DATABASE bingo;
CREATE USER 'bingo_user'@'localhost' IDENTIFIED BY 'senha_forte_aqui';
GRANT ALL PRIVILEGES ON bingo.* TO 'bingo_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

```bash
mysql -u bingo_user -p bingo < /caminho/para/database.sql
```

### 5. Fazer Upload do Back-end

```bash
# No seu computador local
cd /Users/ronaldodiasdesousa/Desktop/Bingo/bingo-backend
GOOS=linux GOARCH=amd64 go build -o bingo-backend main.go
scp bingo-backend root@seu_ip_vps:/opt/bingo-backend/
scp env.template root@seu_ip_vps:/opt/bingo-backend/.env
```

### 6. Configurar Back-end na VPS

```bash
# Na VPS
mkdir -p /opt/bingo-backend
cd /opt/bingo-backend

# Editar .env
nano .env
```

Configure:
```bash
DB_USER=bingo_user
DB_PASSWORD=senha_forte_aqui
DB_HOST=localhost
DB_PORT=3306
DB_NAME=bingo
PORT=8080
```

### 7. Criar Serviço Systemd

```bash
nano /etc/systemd/system/bingo-backend.service
```

```ini
[Unit]
Description=Bingo Backend Service
After=network.target mysql.service

[Service]
Type=simple
User=root
WorkingDirectory=/opt/bingo-backend
EnvironmentFile=/opt/bingo-backend/.env
ExecStart=/opt/bingo-backend/bingo-backend
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
systemctl daemon-reload
systemctl enable bingo-backend
systemctl start bingo-backend
systemctl status bingo-backend
```

### 8. Configurar Nginx como Proxy Reverso

```bash
nano /etc/nginx/sites-available/bingo
```

```nginx
# Front-end
server {
    listen 80;
    server_name seu_dominio.com ou seu_ip;

    root /var/www/bingo;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /static/ {
        alias /var/www/bingo/static/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}

# Back-end API
server {
    listen 80;
    server_name api.seu_dominio.com ou seu_ip;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
ln -s /etc/nginx/sites-available/bingo /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

### 9. Fazer Upload do Front-end

```bash
# No seu computador local
cd /Users/ronaldodiasdesousa/Desktop/Bingo/bingo-frontend
echo "REACT_APP_API_URL=http://seu_ip_vps:8080" > .env.production
npm run build
scp -r build/* root@seu_ip_vps:/var/www/bingo/
```

### 10. Configurar SSL com Let's Encrypt (Opcional)

```bash
apt install certbot python3-certbot-nginx -y
certbot --nginx -d seu_dominio.com
```

## Estrutura Final na VPS

```
/opt/bingo-backend/          # Back-end Go
  ├── bingo-backend          # Executável
  └── .env                   # Configurações

/var/www/bingo/              # Front-end React
  ├── index.html
  └── static/

/etc/nginx/sites-available/  # Configuração Nginx
  └── bingo
```

## Comandos Úteis

```bash
# Ver logs do back-end
journalctl -u bingo-backend -f

# Reiniciar back-end
systemctl restart bingo-backend

# Ver logs do Nginx
tail -f /var/log/nginx/error.log

# Reiniciar Nginx
systemctl restart nginx
```

## Vantagens da VPS vs Hospedagem Compartilhada

| Aspecto | VPS | Hospedagem Compartilhada |
|---------|-----|--------------------------|
| Controle | Total | Limitado |
| Permissões | Sem restrições | Restritas |
| Performance | Dedicada | Compartilhada |
| Configuração | Livre | Limitada |
| SSL | Fácil (Let's Encrypt) | Via painel |
| Custo | Maior | Menor |

## Recomendações de VPS

- **DigitalOcean**: $6/mês (1GB RAM)
- **Linode**: $5/mês (1GB RAM)
- **Vultr**: $6/mês (1GB RAM)
- **AWS Lightsail**: $3.50/mês (512MB RAM)

Todas oferecem VPS com Ubuntu/Debian prontas para uso!

