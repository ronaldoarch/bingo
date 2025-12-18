-- Script SQL para criar a tabela de usuários
-- Execute este arquivo no phpMyAdmin ou MySQL

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir usuário de teste (senha: password)
-- O hash abaixo corresponde à senha 'password' usando bcrypt
-- Para criar novos usuários, use o script create_user.go ou gere o hash no Go
INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu')
ON DUPLICATE KEY UPDATE username=username;

