package db

import (
	"database/sql"
	"log"
	"os"

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
	
	// Construir string de conexão
	// Usar 127.0.0.1 ao invés de localhost para forçar IPv4 e evitar problemas com ::1
	if dbHost == "localhost" {
		dbHost = "127.0.0.1"
	}
	
	// Verificar se precisa usar SSL (Railway, produção, etc)
	useSSL := getEnv("DB_USE_SSL", "false")
	connectionString := dbUser + ":" + dbPassword + "@tcp(" + dbHost + ":" + dbPort + ")/" + dbName
	if useSSL == "true" {
		connectionString += "?tls=true"
	}
	
	db, err = sql.Open("mysql", connectionString)
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados:", err)
	}

	// Testar a conexão
	err = db.Ping()
	if err != nil {
		log.Fatal("Erro ao fazer ping no banco de dados:", err)
	}

	log.Println("Conexão com o banco de dados estabelecida com sucesso!")
}

// getEnv retorna uma variável de ambiente ou um valor padrão
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

func GetUserByUsername(username string) (models.User, error) {
	var user models.User
	err := db.QueryRow("SELECT id, username, password FROM users WHERE username = ?", username).Scan(&user.ID, &user.Username, &user.Password)
	if err != nil {
		return user, err
	}
	return user, nil
}

