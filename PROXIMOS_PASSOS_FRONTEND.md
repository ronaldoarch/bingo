# Próximos Passos - Deploy Frontend no Coolify

## ✅ Você está no caminho certo!

Você selecionou **Dockerfile** - isso está correto! ✅

## 📋 Configurações Necessárias

### 1. Informações Básicas
- **Base Directory**: `bingo-frontend`
- **Build Pack**: `Dockerfile` ✅ (já selecionado)
- **Port**: `80`

### 2. Dockerfile Path
- **Dockerfile Path**: `bingo-frontend/Dockerfile`

### 3. Variáveis de Ambiente (IMPORTANTE!)

Após continuar, você precisará adicionar esta variável:

```
REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com
```

⚠️ **Use a URL do seu back-end que já está rodando!**

### 4. Após o Deploy

1. O Coolify vai gerar uma URL automática para o frontend
2. Anote essa URL (será algo como `https://[hash].agenciamidas.com`)
3. Depois, atualize o `CORS_ORIGIN` no back-end com essa URL do frontend

## 🔄 Fluxo Completo

```
1. Configurar frontend no Coolify ✅ (você está aqui)
   ↓
2. Adicionar variável REACT_APP_API_URL
   ↓
3. Fazer deploy
   ↓
4. Anotar URL do frontend gerada
   ↓
5. Atualizar CORS_ORIGIN no back-end
   ↓
6. Testar login no frontend
```

## ✅ Checklist

- [x] Selecionar Dockerfile como Build Pack
- [ ] Configurar Base Directory: `bingo-frontend`
- [ ] Configurar Port: `80`
- [ ] Configurar Dockerfile Path: `bingo-frontend/Dockerfile`
- [ ] Adicionar variável `REACT_APP_API_URL`
- [ ] Fazer deploy
- [ ] Anotar URL do frontend
- [ ] Atualizar CORS no back-end

## 🎯 Próximo Passo Imediato

Clique em **"Continue"** e configure:
- Base Directory: `bingo-frontend`
- Port: `80`
- Dockerfile Path: `bingo-frontend/Dockerfile`

Depois adicione a variável de ambiente `REACT_APP_API_URL`!

