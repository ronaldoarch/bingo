# Configurar Variável REACT_APP_API_URL no Frontend

## ✅ Frontend Funcionando

Os logs mostram que o frontend está rodando perfeitamente:
- ✅ Nginx iniciado
- ✅ Servindo arquivos estáticos
- ✅ Acessível em `https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com`

## ❌ Problema: Frontend não conecta ao Backend

O erro "Erro ao conectar com o servidor" acontece porque a variável `REACT_APP_API_URL` não está configurada ou está incorreta.

## 🔧 Solução

### No Coolify - Serviço do Frontend

1. Vá em **Environment Variables** do serviço do frontend
2. Adicione/atualize a variável:

```
REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com
```

⚠️ **IMPORTANTE**: 
- Use a URL completa do backend (com `https://`)
- Não adicione `/login` ou `/register` no final
- Apenas a URL base do backend

### Verificar CORS no Backend

No serviço do backend, verifique se está configurado:

```
CORS_ORIGIN=https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com
```

## 🔄 Após Configurar

1. **Redeploy do Frontend** (importante! Variáveis precisam estar no build)
2. **Redeploy do Backend** (se mudou CORS_ORIGIN)

## ⚠️ Importante sobre Variáveis React

Variáveis `REACT_APP_*` são **embutidas no build** durante a compilação. Isso significa:

- Se você adicionar a variável **depois** do build, ela não será aplicada
- É necessário fazer **redeploy** para que a variável seja incluída no build
- O Dockerfile do frontend usa `npm run build`, que compila o React com as variáveis

## 📋 Checklist

- [ ] Variável `REACT_APP_API_URL` configurada no Coolify (frontend)
- [ ] Variável `CORS_ORIGIN` configurada no Coolify (backend)
- [ ] Redeploy do frontend (para aplicar REACT_APP_API_URL)
- [ ] Redeploy do backend (se mudou CORS)
- [ ] Testar login/cadastro

## 🔍 Como Verificar se Funcionou

Após o redeploy:

1. Acesse o frontend
2. Abra o **Console do Navegador** (F12 → Console)
3. Tente fazer login ou cadastro
4. Veja se há erros de CORS ou conexão
5. Se não houver erros, deve funcionar!

## 🐛 Se Ainda Não Funcionar

Verifique no Console do Navegador:
- Se a requisição está indo para a URL correta do backend
- Se há erros de CORS
- Se há erros de rede

Copie os erros do console e verifique a configuração.

