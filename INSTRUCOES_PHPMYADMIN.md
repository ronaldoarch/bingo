# Instruções para Criar Tabela no phpMyAdmin

## ✅ Arquivo SQL Correto

Use o arquivo `create_table.sql` que contém apenas SQL válido.

## Passo a Passo no phpMyAdmin

1. **Acesse o phpMyAdmin:**
   - No painel Hostinger → MySQL Databases
   - Clique em "phpMyAdmin" ou "Acessar phpMyAdmin"

2. **Selecione o banco de dados:**
   - No painel esquerdo, clique em `u127271520_bingo` (ou o nome do seu banco)

3. **Abra a aba SQL:**
   - Clique na aba "SQL" no topo

4. **Cole o SQL abaixo:**

```sql
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu')
ON DUPLICATE KEY UPDATE username=username;
```

5. **Execute:**
   - Clique em "Executar" ou pressione Ctrl+Enter

6. **Verificar:**
   - Você deve ver uma mensagem de sucesso
   - A tabela `users` deve aparecer na lista de tabelas

## Ou Use o Arquivo SQL

1. Na aba "Importar" do phpMyAdmin
2. Escolha o arquivo `create_table.sql`
3. Clique em "Executar"

## Credenciais de Teste

Após criar a tabela, você terá um usuário de teste:
- **Usuário:** `user1`
- **Senha:** `password`

## Próximo Passo

Depois de criar a tabela, configure as variáveis de ambiente no servidor e teste o back-end!

