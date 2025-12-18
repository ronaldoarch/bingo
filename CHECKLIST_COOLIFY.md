# Checklist de Configuração no Coolify

## ✅ Variáveis Já Configuradas

Você já tem estas variáveis configuradas:
- ✅ `DB_USER=root`
- ✅ `DB_PASSWORD=NVkFDIeGcWKZvikmOJXbnVeXiNSuTtJR`
- ✅ `DB_HOST=mysql.railway.internal`
- ✅ `DB_PORT=50811` (ou 3306)
- ✅ `DB_NAME=railway`

## ⚠️ Variáveis que Faltam Adicionar

Adicione estas 3 variáveis no Coolify:

### 1. DB_USE_SSL
```
DB_USE_SSL=true
```
**Por quê?** Railway MySQL requer SSL para conexões seguras.

### 2. PORT
```
PORT=8080
```
**Por quê?** Porta onde o back-end Go vai rodar.

### 3. CORS_ORIGIN
```
CORS_ORIGIN=https://seudominio.com
```
**Por quê?** Permite que o front-end faça requisições ao back-end.
(Ajuste depois com a URL real do front-end)

## 📝 Sobre a Porta DB_PORT

Você configurou `DB_PORT=50811`, mas:

- **Porta interna do Railway**: `3306` (para `mysql.railway.internal`)
- **Porta externa**: `50811` (para conexões de fora)

**Recomendação**: 
- Se o Coolify está na mesma rede/VPS: use `3306`
- Se for conexão externa: use `50811`

Mas como você está usando `mysql.railway.internal`, tente primeiro com `3306`. Se não funcionar, use `50811`.

## ✅ Checklist Final

- [ ] Adicionar `DB_USE_SSL=true`
- [ ] Adicionar `PORT=8080`
- [ ] Adicionar `CORS_ORIGIN=https://seudominio.com`
- [ ] Verificar se `DB_PORT` está correto (tente 3306 primeiro)
- [ ] Salvar variáveis
- [ ] Fazer deploy/redeploy
- [ ] Verificar logs para confirmar criação das tabelas

## 🔍 Verificar Logs

Após o deploy, os logs devem mostrar:

```
Conexão com o banco de dados estabelecida com sucesso!
Tabela 'users' criada/verificada com sucesso!
Usuário de teste 'user1' criado com sucesso!
Servidor rodando na porta 8080
```

Se aparecer erro de conexão, verifique:
1. Se `DB_PORT` está correto (tente 3306)
2. Se `DB_USE_SSL=true` está configurado
3. Se as credenciais estão corretas

