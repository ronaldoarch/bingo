package main

// Exemplo de arquivo de configuração
// Copie este arquivo para config.go e ajuste as configurações conforme necessário

const (
	// Configurações do Banco de Dados
	DBUser     = "root"
	DBPassword = "password"
	DBHost     = "localhost"
	DBPort     = "3306"
	DBName     = "bingo"
	
	// Configurações do Servidor
	ServerPort = ":8080"
)

// GetDBConnectionString retorna a string de conexão formatada
func GetDBConnectionString() string {
	return DBUser + ":" + DBPassword + "@tcp(" + DBHost + ":" + DBPort + ")/" + DBName
}

