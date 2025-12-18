# Configurar Variáveis no Coolify - Railway MySQL

## 🔑 Variáveis do Railway MySQL

Quando você cria MySQL no Railway, ele fornece estas variáveis:

- `MYSQLHOST` - Host do banco
- `MYSQLPORT` - Porta (geralmente 3306)
- `MYSQLDATABASE` - Nome do banco
- `MYSQLUSER` - Usuário (pode ser `root`)
- `MYSQL_ROOT_PASSWORD` - Senha do root
- `MYSQLPASSWORD` - Senha alternativa (se houver)

## ✅ Configuração no Coolify

### Se o usuário é `root`:

No Coolify, configure estas variáveis:

```
DB_USER=root
DB_PASSWORD=[valor de MYSQL_ROOT_PASSWORD]
DB_HOST=[valor de MYSQLHOST]
DB_PORT=[valor de MYSQLPORT]
DB_NAME=[valor de MYSQLDATABASE]
DB_USE_SSL=true
PORT=8080
CORS_ORIGIN=https://seudominio.com
```

### Exemplo Prático:

Se o Railway mostra:
```
MYSQLHOST=containers-us-west-123.railway.app
MYSQLPORT=3306
MYSQLDATABASE=railway
MYSQLUSER=root
MYSQL_ROOT_PASSWORD=abc123xyz789
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
CORS_ORIGIN=https://seudominio.com
```

## 📝 Resumo

| Railway Variable | Coolify Variable | Valor |
|------------------|------------------|-------|
| `MYSQLUSER` ou `root` | `DB_USER` | `root` |
| `MYSQL_ROOT_PASSWORD` | `DB_PASSWORD` | (copiar valor) |
| `MYSQLHOST` | `DB_HOST` | (copiar valor) |
| `MYSQLPORT` | `DB_PORT` | (copiar valor) |
| `MYSQLDATABASE` | `DB_NAME` | (copiar valor) |
| - | `DB_USE_SSL` | `true` |
| - | `PORT` | `8080` |
| - | `CORS_ORIGIN` | URL do front-end |

## ⚠️ Importante

- **Use `MYSQL_ROOT_PASSWORD`** como senha (não `MYSQLPASSWORD`)
- **Sempre adicione `DB_USE_SSL=true`** (Railway requer SSL)
- **Copie os valores exatos** do Railway (sem espaços extras)

## 🔒 Segurança

No Coolify, você pode usar **"Secrets"** para senhas:
1. Vá em **"Secrets"** no Coolify
2. Crie um secret: `mysql_password` = valor de `MYSQL_ROOT_PASSWORD`
3. Use nas variáveis: `DB_PASSWORD={{secrets.mysql_password}}`

