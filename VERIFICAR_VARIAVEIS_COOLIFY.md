# Verificar Variáveis no Coolify

## ⚠️ Problema Atual

O erro mostra que a string de conexão está malformada. Isso geralmente acontece quando as variáveis estão configuradas incorretamente.

## ✅ Variáveis Corretas

No Coolify, no serviço do **back-end**, verifique se as variáveis estão assim:

```
DB_HOST=shortline.proxy.rlwy.net
DB_PORT=50811
DB_USER=root
DB_PASSWORD=NVkFDIeGcWKZvikm0JXbnVeXiNSuTtJR
DB_NAME=railway
DB_USE_SSL=true
PORT=8080
CORS_ORIGIN=https://seudominio.com
```

## ❌ Erros Comuns

### Erro 1: DB_HOST com porta incluída
```
❌ DB_HOST=shortline.proxy.rlwy.net:50811
✅ DB_HOST=shortline.proxy.rlwy.net
```

### Erro 2: DB_HOST com caminho incluído
```
❌ DB_HOST=shortline.proxy.rlwy.net/railway
✅ DB_HOST=shortline.proxy.rlwy.net
```

### Erro 3: DB_PORT vazio ou incorreto
```
❌ DB_PORT= (vazio)
✅ DB_PORT=50811
```

### Erro 4: DB_NAME incorreto
```
❌ DB_NAME=bingo
✅ DB_NAME=railway
```

## 🔍 Como Verificar no Railway

1. Acesse o Railway → Seu MySQL → **Variables**
2. Procure por:
   - `MYSQLHOST` ou `MYSQL_HOST` → use como `DB_HOST`
   - `MYSQLPORT` ou `MYSQL_PORT` → use como `DB_PORT` (se for porta pública)
   - `MYSQLDATABASE` ou `MYSQL_DATABASE` → use como `DB_NAME`
   - `MYSQLUSER` ou `MYSQL_USER` → use como `DB_USER`
   - `MYSQL_ROOT_PASSWORD` → use como `DB_PASSWORD`

3. **OU** use `MYSQL_PUBLIC_URL`:
   ```
   mysql://root:SENHA@shortline.proxy.rlwy.net:50811/railway
   ```
   - Host: `shortline.proxy.rlwy.net`
   - Porta: `50811`
   - Database: `railway`
   - User: `root`
   - Password: `SENHA`

## 📋 Checklist

- [ ] `DB_HOST` contém apenas o hostname (sem porta, sem caminho)
- [ ] `DB_PORT` contém apenas números (ex: `50811`)
- [ ] `DB_USER` está correto (geralmente `root`)
- [ ] `DB_PASSWORD` está correto (sem espaços extras)
- [ ] `DB_NAME` está correto (geralmente `railway`)
- [ ] `DB_USE_SSL=true` está configurado
- [ ] Todas as variáveis estão sem espaços extras no início/fim

## 🔄 Após Corrigir

1. Salve as variáveis no Coolify
2. Faça **redeploy** do back-end
3. Verifique os logs - deve aparecer:
   ```
   Tentando conectar ao MySQL: root@tcp(shortline.proxy.rlwy.net:50811)/railway (SSL: true)
   Conexão com o banco de dados estabelecida com sucesso!
   ```

## 🐛 Se Ainda Não Funcionar

Verifique os logs do Coolify. O código agora mostra a string de conexão (sem senha) para debug. Se ainda houver erro, copie a mensagem completa dos logs.

