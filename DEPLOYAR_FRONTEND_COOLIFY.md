# Como Deployar o Frontend no Coolify

## 📍 Situação Atual

- ✅ **Back-end já deployado**: `https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com`
- ❌ **Front-end ainda não deployado**

## 🚀 Passo a Passo para Deployar o Frontend

### 1. Criar Novo Serviço no Coolify

1. No Coolify, clique em **"New Resource"** → **"Application"** → **"GitHub"**
2. Configure:
   - **Repository**: `ronaldoarch/bingo`
   - **Branch**: `main`
   - **Base Directory**: `bingo-frontend`
   - **Build Pack**: **Docker** ⚠️ (importante!)
   - **Port**: `80`
   - **Dockerfile Path**: `bingo-frontend/Dockerfile`

### 2. Configurar Variáveis de Ambiente

No serviço do frontend, adicione:

```
REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com
```

⚠️ **IMPORTANTE**: Use a URL do seu back-end que já está rodando!

### 3. Deploy

1. Clique em **"Deploy"**
2. Aguarde o build completar
3. O Coolify vai gerar uma URL automática para o frontend

### 4. URL do Frontend

Após o deploy, o Coolify vai gerar uma URL similar a:
```
https://[hash-aleatorio].agenciamidas.com
```

Esta será a **URL do frontend**!

### 5. Atualizar CORS no Back-end

Depois que o frontend estiver deployado:

1. No serviço do **back-end**, vá em **"Environment Variables"**
2. Atualize `CORS_ORIGIN` com a URL do frontend:
   ```
   CORS_ORIGIN=https://[url-do-frontend]
   ```
3. Faça **"Redeploy"** do back-end

## 📝 Resumo das URLs

- **Back-end**: `https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com`
- **Front-end**: `https://[será gerado após deploy]`

## ✅ Checklist

- [ ] Criar serviço frontend no Coolify
- [ ] Configurar `REACT_APP_API_URL` com URL do back-end
- [ ] Fazer deploy
- [ ] Anotar URL do frontend gerada
- [ ] Atualizar `CORS_ORIGIN` no back-end
- [ ] Testar acesso ao frontend

## 🔍 Verificar se Funcionou

1. Acesse a URL do frontend no navegador
2. Deve aparecer a tela de login
3. Teste fazer login:
   - Usuário: `user1`
   - Senha: `password`

