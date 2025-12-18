# Corrigir Conexão com MySQL Railway

## ❌ Problema

O erro mostra:
```
dial tcp: lookup mysql.railway.internal on 127.0.0.11:53: no such host
```

Isso acontece porque `mysql.railway.internal` só funciona **dentro da rede do Railway**. Como o Coolify está em outro servidor, precisa usar a **URL pública** do MySQL.

## ✅ Solução

### 1. Obter URL Pública do MySQL no Railway

No painel do Railway, vá em **"Variables"** do seu serviço MySQL e procure:

- `MYSQL_PUBLIC_URL` ou
- `MYSQL_URL` (pode ter a URL pública)

A URL pública geralmente tem o formato:
```
mysql://root:senha@shortline.proxy.rlwy.net:PORTA/railway
```

Ou você pode ver a URL pública na aba **"Connect"** ou **"Public Network"** do MySQL no Railway.

### 2. Atualizar Variáveis no Coolify

No Coolify, no serviço do **back-end**, atualize as variáveis de ambiente:

#### Opção A: Usar URL Pública Completa (Mais Fácil)

Se o Railway fornecer `MYSQL_PUBLIC_URL`, você pode extrair os valores:

```
DB_HOST=shortline.proxy.rlwy.net
DB_PORT=50811 (ou a porta pública que aparecer)
DB_USER=root
DB_PASSWORD=sua_senha_aqui
DB_NAME=railway
DB_USE_SSL=true
```

#### Opção B: Usar MYSQL_URL do Railway

Se você tiver acesso à `MYSQL_URL` ou `MYSQL_PUBLIC_URL` completa, pode atualizar o código para usar essa URL diretamente.

### 3. Verificar Porta

⚠️ **IMPORTANTE**: A porta pública do Railway é diferente da porta interna!

- **Porta interna**: `3306` (para `mysql.railway.internal`)
- **Porta pública**: Geralmente algo como `50811` ou outra (veja na URL pública)

Use a **porta pública** nas variáveis do Coolify!

## 📋 Checklist

1. [ ] Acessar Railway → MySQL → Variables
2. [ ] Copiar `MYSQL_PUBLIC_URL` ou valores de `MYSQL_HOST`, `MYSQL_PORT`, etc.
3. [ ] No Coolify, atualizar variáveis do back-end:
   - `DB_HOST` = hostname público (ex: `shortline.proxy.rlwy.net`)
   - `DB_PORT` = porta pública (ex: `50811`)
   - `DB_USER` = `root`
   - `DB_PASSWORD` = senha do Railway
   - `DB_NAME` = `railway`
   - `DB_USE_SSL` = `true`
4. [ ] Salvar variáveis
5. [ ] Fazer redeploy do back-end
6. [ ] Verificar logs - deve conectar com sucesso!

## 🔍 Exemplo de Variáveis Corretas

Baseado na imagem que você mostrou antes, você tinha:
- `MYSQL_PUBLIC_URL`: `mysql://root:NVkFDIeGcWKZvikm0JXbnVeXiNSuTtJR@shortline.proxy.rlwy.net:50811/railway`

Então as variáveis devem ser:
```
DB_HOST=shortline.proxy.rlwy.net
DB_PORT=50811
DB_USER=root
DB_PASSWORD=NVkFDIeGcWKZvikm0JXbnVeXiNSuTtJR
DB_NAME=railway
DB_USE_SSL=true
```

## ⚠️ Nota sobre Segurança

A URL pública do Railway expõe o MySQL na internet. Certifique-se de:
- Usar senha forte
- Habilitar SSL (`DB_USE_SSL=true`)
- Considerar usar firewall/whitelist de IPs se possível

