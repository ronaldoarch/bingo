-- Script SQL para criar o banco de dados e tabela de usuários

CREATE DATABASE IF NOT EXISTS bingo;

USE bingo;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Exemplo de inserção de usuário de teste
-- A senha 'password' foi hasheada com bcrypt
-- Para gerar um novo hash, use a função bcrypt.GenerateFromPassword no Go
INSERT INTO users (username, password) VALUES 
('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu');

-- Nota: O hash acima corresponde à senha 'password'
-- Para criar novos usuários, você precisará gerar o hash da senha usando bcrypt no Go

