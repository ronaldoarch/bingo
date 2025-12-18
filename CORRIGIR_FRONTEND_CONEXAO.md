# Corrigir Conexão do Frontend com Backend

## ✅ Backend Funcionando

Os logs mostram que o backend está funcionando perfeitamente:
- ✅ Conectou ao MySQL
- ✅ Criou tabela 'users'
- ✅ Criou usuário de teste 'user1'
- ✅ Servidor rodando na porta 8080

## ❌ Problema: Frontend não conecta ao Backend

O erro "Erro ao conectar com o servidor" indica que o frontend não consegue alcançar o backend.

## 🔧 Solução

### 1. Verificar URL do Backend

No Coolify, você tem:
- **Frontend**: `https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com`
- **Backend**: `https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com`

### 2. Configurar Variável no Frontend

No Coolify, no serviço do **frontend**, adicione/atualize a variável:

```
REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com
```

⚠️ **IMPORTANTE**: Use a URL completa do backend (com `https://`)

### 3. Verificar CORS no Backend

No Coolify, no serviço do **back-end**, verifique se a variável está configurada:

```
CORS_ORIGIN=https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com
```

⚠️ **IMPORTANTE**: Use a URL completa do frontend (com `https://`)

### 4. Redeploy

Após configurar as variáveis:

1. **Redeploy do Frontend** (para aplicar `REACT_APP_API_URL`)
2. **Redeploy do Backend** (para aplicar `CORS_ORIGIN`)

## 📋 Checklist

- [ ] `REACT_APP_API_URL` configurado no frontend com URL completa do backend
- [ ] `CORS_ORIGIN` configurado no backend com URL completa do frontend
- [ ] Redeploy do frontend
- [ ] Redeploy do backend
- [ ] Testar login novamente

## 🔍 Verificar se Funcionou

Após o redeploy, ao tentar fazer login:
- ✅ Deve conectar ao backend
- ✅ Deve fazer login com sucesso
- ✅ Deve redirecionar para a home

## 🐛 Se Ainda Não Funcionar

1. Abra o **Console do Navegador** (F12 → Console)
2. Tente fazer login
3. Veja se há erros de CORS ou conexão
4. Copie os erros e verifique:
   - Se a URL do backend está correta
   - Se o CORS está permitindo a origem do frontend

