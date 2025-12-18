package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"bingo-backend/utils"
)

// Script auxiliar para criar novos usuários no banco de dados
// Uso: go run create_user.go <username> <password>
func main() {
	if len(os.Args) < 3 {
		fmt.Println("Uso: go run create_user.go <username> <password>")
		os.Exit(1)
	}

	username := os.Args[1]
	password := os.Args[2]

	// Gerar hash da senha
	hashedPassword, err := utils.GeneratePasswordHash(password)
	if err != nil {
		log.Fatal("Erro ao gerar hash da senha:", err)
	}

	// Conectar ao banco de dados
	db, err := sql.Open("mysql", "root:password@tcp(localhost:3306)/bingo")
	if err != nil {
		log.Fatal("Erro ao conectar ao banco de dados:", err)
	}
	defer db.Close()

	// Inserir usuário
	_, err = db.Exec("INSERT INTO users (username, password) VALUES (?, ?)", username, hashedPassword)
	if err != nil {
		log.Fatal("Erro ao inserir usuário:", err)
	}

	fmt.Printf("Usuário '%s' criado com sucesso!\n", username)
	fmt.Printf("Hash da senha: %s\n", hashedPassword)
}

