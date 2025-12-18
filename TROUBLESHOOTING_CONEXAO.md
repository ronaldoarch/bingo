# Troubleshooting - Erro ao Conectar com Servidor

## ✅ Variáveis Configuradas

- Frontend: `REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com` ✅
- Backend: `CORS_ORIGIN=https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com` ✅

## 🔍 Verificações Necessárias

### 1. Verificar se o Redeploy foi Feito

**Frontend:**
- ✅ Variável `REACT_APP_API_URL` configurada
- ❓ Redeploy foi feito após adicionar a variável?

**Backend:**
- ✅ Variável `CORS_ORIGIN` configurada
- ❓ Redeploy foi feito após adicionar a variável?

### 2. Verificar Console do Navegador

1. Abra o frontend no navegador
2. Pressione **F12** para abrir DevTools
3. Vá na aba **Console**
4. Tente fazer login
5. Veja os erros que aparecem

**Possíveis erros:**

#### Erro de CORS:
```
Access to fetch at 'https://...' from origin 'https://...' has been blocked by CORS policy
```
**Solução**: Verificar se `CORS_ORIGIN` está correto e fazer redeploy do backend

#### Erro de Rede:
```
Failed to fetch
NetworkError when attempting to fetch resource
```
**Solução**: Verificar se a URL do backend está correta e acessível

#### Erro 404:
```
404 Not Found
```
**Solução**: Verificar se a URL está correta (sem `/login` no final)

### 3. Verificar se Backend está Acessível

Teste acessar diretamente o backend no navegador:
```
https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com/login
```

**Esperado**: Deve retornar erro 405 (Method Not Allowed) ou similar, mas **não** erro de conexão.

Se der erro de conexão, o backend não está acessível publicamente.

### 4. Verificar Logs do Backend

No Coolify, verifique os logs do backend:
- Deve mostrar: `Servidor rodando na porta :8080`
- Não deve ter erros de conexão

### 5. Verificar Variável no Build do Frontend

Como `REACT_APP_API_URL` é compilada no build, verifique:

1. No navegador, pressione **F12**
2. Vá na aba **Network**
3. Tente fazer login
4. Veja qual URL está sendo chamada

Se estiver chamando `http://localhost:8080`, significa que a variável não foi incluída no build.

## 🔧 Soluções

### Solução 1: Fazer Redeploy Completo

1. **Frontend**: Redeploy completo (não apenas restart)
2. **Backend**: Redeploy completo (não apenas restart)

### Solução 2: Verificar URL no Código

Se após redeploy ainda não funcionar, verifique se a URL está sendo usada corretamente:

No código do frontend (`Login.js` e `Register.js`):
```javascript
const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:8080';
```

Se `process.env.REACT_APP_API_URL` estiver `undefined`, vai usar `localhost`.

### Solução 3: Verificar CORS

No backend, verifique se o middleware CORS está permitindo a origem correta:

```go
allowedOrigin := getEnv("CORS_ORIGIN", "*")
```

Se `CORS_ORIGIN` não estiver definido, vai usar `*` (qualquer origem).

## 📋 Checklist de Debug

- [ ] Redeploy do frontend foi feito após adicionar `REACT_APP_API_URL`?
- [ ] Redeploy do backend foi feito após adicionar `CORS_ORIGIN`?
- [ ] Console do navegador mostra algum erro específico?
- [ ] Backend está acessível publicamente?
- [ ] Logs do backend mostram que está rodando?
- [ ] Network tab mostra qual URL está sendo chamada?

## 🎯 Próximos Passos

1. Abra o Console do Navegador (F12)
2. Tente fazer login
3. Copie os erros que aparecem
4. Verifique qual URL está sendo chamada na aba Network
5. Compartilhe essas informações para diagnóstico mais preciso

