# Corrigir Configuração do Frontend no Coolify

## ✅ Configurações Corretas Atuais

- **Base Directory**: `/bingo-frontend` ✅
- **Build Pack**: `Dockerfile` ✅
- **Domains**: `https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com` ✅

## ⚠️ Ajustes Necessários

### 1. Dockerfile Location

**Atual**: `/Dockerfile`  
**Correto**: `Dockerfile` (sem a barra inicial)

Como o Base Directory já é `/bingo-frontend`, o Dockerfile Location deve ser relativo a esse diretório.

### 2. Remover Custom Docker Options

As opções customizadas podem causar problemas:
```
--cap-add SYS_ADMIN --device=/dev/fuse --security-opt apparmor:unconfined --ulimit nofile=1024:1024 --tmpfs /run:rw,noexec,nosuid,size=65536k --hostname=myapp
```

**Ação**: Deixe o campo **"Custom Docker Options"** **VAZIO** para o frontend React.

### 3. Adicionar Variável de Ambiente

Vá em **"Environment Variables"** e adicione:

```
REACT_APP_API_URL=https://gcsswg0gg0swcog8cwokccwk.agenciamidas.com
```

⚠️ Use a URL do seu **back-end**!

### 4. Verificar Docker Build Stage Target

Deixe o campo **"Docker Build Stage Target"** **VAZIO** (o Dockerfile não usa stages nomeados).

## 📋 Configuração Final Correta

```
Base Directory: /bingo-frontend
Dockerfile Location: Dockerfile
Docker Build Stage Target: (vazio)
Custom Docker Options: (vazio)
Use a Build Server?: (desmarcado)
```

## 🔄 Próximos Passos

1. **Corrigir Dockerfile Location**: Mude de `/Dockerfile` para `Dockerfile`
2. **Limpar Custom Docker Options**: Deixe vazio
3. **Adicionar variável**: `REACT_APP_API_URL` com URL do back-end
4. **Salvar** as configurações
5. **Fazer Deploy** novamente

## 🎯 Após o Deploy

1. O frontend vai rodar na URL: `https://xkc8gcwsowo4k888kcwggsg0.agenciamidas.com`
2. Atualize o `CORS_ORIGIN` no back-end com essa URL
3. Teste o login!

## ✅ Checklist

- [ ] Dockerfile Location: `Dockerfile` (sem barra inicial)
- [ ] Custom Docker Options: vazio
- [ ] Variável `REACT_APP_API_URL` configurada
- [ ] Salvar configurações
- [ ] Fazer deploy
- [ ] Verificar se está rodando (status verde)
- [ ] Atualizar CORS no back-end

