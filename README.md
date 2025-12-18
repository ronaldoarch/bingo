# Sistema de Login - Bingo VIP

Sistema completo de autenticação para um site de bingo, desenvolvido com React (front-end) e Go (back-end), utilizando MySQL como banco de dados.

## Estrutura do Projeto

```
Bingo/
├── bingo-frontend/          # Front-end React
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── App.js
│   │   ├── Login.js
│   │   ├── index.js
│   │   └── style.css
│   └── package.json
│
├── bingo-backend/           # Back-end Go
│   ├── main.go
│   ├── handlers/
│   │   └── login.go
│   ├── models/
│   │   └── user.go
│   ├── db/
│   │   └── connection.go
│   ├── utils/
│   │   └── password.go
│   ├── database.sql
│   └── go.mod
│
└── README.md
```

## Pré-requisitos

### Front-end
- Node.js (versão 16 ou superior)
- npm ou yarn

### Back-end
- Go (versão 1.21 ou superior)
- MySQL (versão 5.7 ou superior)

## Instalação e Configuração

### 1. Configuração do Banco de Dados MySQL

1. Certifique-se de que o MySQL está instalado e rodando
2. Execute o script SQL para criar o banco de dados:

```bash
mysql -u root -p < bingo-backend/database.sql
```

Ou execute os comandos manualmente no MySQL:

```sql
CREATE DATABASE IF NOT EXISTS bingo;
USE bingo;
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

3. Configure a string de conexão no arquivo `bingo-backend/db/connection.go`:

```go
db, err = sql.Open("mysql", "usuario:senha@tcp(host:porta)/bingo")
```

Exemplo:
```go
db, err = sql.Open("mysql", "root:password@tcp(localhost:3306)/bingo")
```

### 2. Configuração do Back-end (Go)

1. Navegue até o diretório do back-end:

```bash
cd bingo-backend
```

2. Instale as dependências:

```bash
go mod download
```

3. Execute o servidor:

```bash
go run main.go
```

O servidor estará rodando em `http://localhost:8080`

### 3. Configuração do Front-end (React)

1. Navegue até o diretório do front-end:

```bash
cd bingo-frontend
```

2. Instale as dependências:

```bash
npm install
```

3. Inicie o servidor de desenvolvimento:

```bash
npm start
```

O front-end estará rodando em `http://localhost:3000`

## Como Usar

1. Certifique-se de que o MySQL está rodando
2. Inicie o servidor Go (back-end)
3. Inicie o servidor React (front-end)
4. Acesse `http://localhost:3000` no navegador
5. Use as credenciais de teste:
   - **Usuário:** `user1`
   - **Senha:** `password`

## Criando Novos Usuários

Para criar novos usuários com senhas hasheadas, você pode usar o utilitário fornecido em `bingo-backend/utils/password.go`. Exemplo de uso:

```go
package main

import (
    "fmt"
    "bingo-backend/utils"
)

func main() {
    password := "minhasenha123"
    hash, err := utils.GeneratePasswordHash(password)
    if err != nil {
        fmt.Println("Erro:", err)
        return
    }
    fmt.Println("Hash da senha:", hash)
}
```

Depois, insira o usuário no banco de dados:

```sql
INSERT INTO users (username, password) VALUES ('novousuario', 'hash_gerado_aqui');
```

## Endpoints da API

### POST /login

Autentica um usuário.

**Request Body:**
```json
{
  "username": "user1",
  "password": "password"
}
```

**Response Success (200):**
```json
{
  "success": true,
  "message": "Login bem-sucedido",
  "user": {
    "id": 1,
    "username": "user1"
  }
}
```

**Response Error (401):**
```json
{
  "success": false,
  "message": "Usuário não encontrado"
}
```

ou

```json
{
  "success": false,
  "message": "Senha inválida"
}
```

## Segurança

- As senhas são armazenadas usando hash bcrypt
- CORS está configurado para permitir requisições do front-end
- Validação de entrada no front-end e back-end

## Deploy na Hostinger

Para fazer deploy na Hostinger, consulte os guias detalhados:

- **[QUICK_DEPLOY.md](QUICK_DEPLOY.md)** - Guia rápido de deploy (5 minutos)
- **[DEPLOY_HOSTINGER.md](DEPLOY_HOSTINGER.md)** - Guia completo e detalhado

### Preparação Rápida

```bash
# 1. Preparar arquivos para deploy
./deploy.sh

# 2. Siga as instruções em QUICK_DEPLOY.md
```

## Próximos Passos

Funcionalidades que podem ser adicionadas:

- [ ] Sistema de registro de novos usuários
- [ ] Recuperação de senha
- [ ] Autenticação com JWT tokens
- [ ] Logs de acesso
- [ ] Rate limiting
- [ ] Validação de CPF, telefone e e-mail
- [ ] Sistema de sessão

## Tecnologias Utilizadas

- **Front-end:** React 18, CSS3, HTML5
- **Back-end:** Go (Golang), Gorilla Mux
- **Banco de Dados:** MySQL
- **Segurança:** bcrypt para hash de senhas

## Licença

Este projeto é de código aberto e está disponível para uso pessoal e comercial.

