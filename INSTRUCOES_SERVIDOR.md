# Instruções para Executar no Servidor

Você está conectado ao servidor Hostinger. Siga estes passos:

## 1. Verificar se o Go está instalado

```bash
go version
```

Se não estiver instalado, você precisará:
- Instalar o Go no servidor, OU
- Compilar no seu computador local e fazer upload do executável

## 2. Opção A: Compilar no Servidor (se Go estiver instalado)

```bash
cd ~/bingo-backend
go mod download
go build -o bingo-backend main.go
chmod +x bingo-backend
```

## 3. Opção B: Fazer Upload do Código-Fonte

No seu computador local, execute:

```bash
./upload_source.sh
```

Depois, no servidor:

```bash
cd ~/bingo-backend
go mod download
go build -o bingo-backend main.go
chmod +x bingo-backend
```

## 4. Configurar Variáveis de Ambiente

```bash
cd ~/bingo-backend
cp env.template .env
nano .env
```

Configure com suas credenciais do MySQL:
```bash
DB_USER=seu_usuario_mysql
DB_PASSWORD=sua_senha_mysql
DB_HOST=localhost
DB_PORT=3306
DB_NAME=bingo
PORT=8080
```

## 5. Configurar Banco de Dados

1. Acesse o painel Hostinger → MySQL Databases
2. Crie o banco `bingo` (se não existir)
3. Execute o SQL:

```sql
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 6. Testar o Back-end

```bash
cd ~/bingo-backend
./bingo-backend
```

Se funcionar, pressione `Ctrl+C` e configure como serviço.

## 7. Configurar como Serviço (Opcional)

```bash
sudo nano /etc/systemd/system/bingo-backend.service
```

Cole:

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

Ativar:

```bash
sudo systemctl daemon-reload
sudo systemctl enable bingo-backend
sudo systemctl start bingo-backend
sudo systemctl status bingo-backend
```

