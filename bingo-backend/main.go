package main

import (
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"bingo-backend/handlers"
)

func main() {
	r := mux.NewRouter()

	// Configurar CORS para permitir requisições do front-end
	r.Use(corsMiddleware)

	// Rota de Login
	r.HandleFunc("/login", handlers.Login).Methods("POST")

	// Obter porta das variáveis de ambiente ou usar padrão
	port := getEnv("PORT", "8080")
	if port[0] != ':' {
		port = ":" + port
	}

	// Inicia o servidor
	log.Printf("Servidor rodando na porta %s", port)
	log.Fatal(http.ListenAndServe(port, r))
}

// getEnv retorna uma variável de ambiente ou um valor padrão
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}

// Middleware CORS para permitir requisições do front-end
func corsMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Obter origem permitida das variáveis de ambiente ou usar wildcard
		allowedOrigin := getEnv("CORS_ORIGIN", "*")
		w.Header().Set("Access-Control-Allow-Origin", allowedOrigin)
		w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
		w.Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
		w.Header().Set("Access-Control-Allow-Credentials", "true")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next.ServeHTTP(w, r)
	})
}

