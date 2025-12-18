package db

import (
	"database/sql"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"bingo-backend/models"
)

var db *sql.DB

func init() {
	var err error
	
	// Obter variáveis de ambiente ou usar valores padrão
	dbUser := getEnv("DB_USER", "root")
	dbPassword := getEnv("DB_PASSWORD", "password")
	dbHost := getEnv("DB_HOST", "127.0.0.1") // Usar 127.0.0.1 para evitar IPv6
	dbPort := getEnv("DB_PORT", "3306")
	dbName := getEnv("DB_NAME", "bingo")
	
	// Limpar host - remover porta, caminho ou protocolo se estiverem incluídos
	// Exemplo: "shortline.proxy.rlwy.net:50811" -> "shortline.proxy.rlwy.net"
	if idx := len(dbHost); idx > 0 {
		// Remover tudo após : (porta) ou / (caminho)
		for i := 0; i < len(dbHost); i++ {
			if dbHost[i] == ':' || dbHost[i] == '/' {
				dbHost = dbHost[:i]
				break
			}
		}
	}
	
	// Usar 127.0.0.1 ao invés de localhost para forçar IPv4 e evitar problemas com ::1
	if dbHost == "localhost" {
		dbHost = "127.0.0.1"
	}
	
	// Limpar porta - remover caracteres não numéricos
	dbPort = strings.TrimSpace(dbPort)
	
	// Verificar se precisa usar SSL (Railway, produção, etc)
	useSSL := getEnv("DB_USE_SSL", "false")
	connectionString := dbUser + ":" + dbPassword + "@tcp(" + dbHost + ":" + dbPort + ")/" + dbName
	if useSSL == "true" {
		// Railway usa certificados SSL, mas pode não validar contra o hostname
		// Usar skip-verify para aceitar certificados do Railway
		connectionString += "?tls=skip-verify"
	}
	
	// Log da conexão (sem senha) para debug
	log.Printf("Tentando conectar ao MySQL: %s@tcp(%s:%s)/%s (SSL: %s)", dbUser, dbHost, dbPort, dbName, useSSL)
	
	db, err = sql.Open("mysql", connectionString)
	if err != nil {
		log.Fatalf("Erro ao conectar ao banco de dados: %v", err)
	}

	// Testar a conexão
	err = db.Ping()
	if err != nil {
		log.Fatal("Erro ao fazer ping no banco de dados:", err)
	}

	log.Println("Conexão com o banco de dados estabelecida com sucesso!")

	// Criar tabelas automaticamente
	createTables()
}

// getEnv retorna uma variável de ambiente ou um valor padrão
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

// createTables cria as tabelas necessárias automaticamente
func createTables() {
	createTableSQL := `
	CREATE TABLE IF NOT EXISTS users (
		id INT AUTO_INCREMENT PRIMARY KEY,
		username VARCHAR(255) NOT NULL UNIQUE,
		password VARCHAR(255) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
	`

	_, err := db.Exec(createTableSQL)
	if err != nil {
		log.Printf("Aviso: Erro ao criar tabela users (pode já existir): %v", err)
	} else {
		log.Println("Tabela 'users' criada/verificada com sucesso!")
	}

	// Verificar se existe usuário de teste, se não existir, criar
	var count int
	err = db.QueryRow("SELECT COUNT(*) FROM users WHERE username = 'user1'").Scan(&count)
	if err == nil && count == 0 {
		// Hash da senha 'password' usando bcrypt
		// Este hash foi gerado previamente: $2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu
		testUserSQL := `
		INSERT INTO users (username, password) VALUES 
		('user1', '$2a$10$DJG7uHgCvgq2uZH5p5foBuR5m4ZhxZr3ihSoC2C6OdqlxXH2OZAsu')
		ON DUPLICATE KEY UPDATE username=username;
		`
		_, err = db.Exec(testUserSQL)
		if err != nil {
			log.Printf("Aviso: Erro ao criar usuário de teste: %v", err)
		} else {
			log.Println("Usuário de teste 'user1' criado com sucesso!")
		}
	}
}

func GetUserByUsername(username string) (models.User, error) {
	var user models.User
	err := db.QueryRow("SELECT id, username, password FROM users WHERE username = ?", username).Scan(&user.ID, &user.Username, &user.Password)
	if err != nil {
		return user, err
	}
	return user, nil
}

// CreateUser cria um novo usuário no banco de dados
func CreateUser(username, hashedPassword string) (models.User, error) {
	var user models.User
	result, err := db.Exec("INSERT INTO users (username, password) VALUES (?, ?)", username, hashedPassword)
	if err != nil {
		return user, err
	}

	id, err := result.LastInsertId()
	if err != nil {
		return user, err
	}

	user.ID = int(id)
	user.Username = username
	user.Password = hashedPassword

	return user, nil
}

