package handlers

import (
	"encoding/json"
	"net/http"

	"bingo-backend/db"
	"bingo-backend/models"

	"golang.org/x/crypto/bcrypt"
)

func Login(w http.ResponseWriter, r *http.Request) {
	// Garantir que Content-Type está definido
	w.Header().Set("Content-Type", "application/json")
	
	var loginDetails models.LoginDetails

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&loginDetails)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Erro na leitura do corpo da requisição",
		})
		return
	}

	// Conectar ao banco de dados e verificar as credenciais
	user, err := db.GetUserByUsername(loginDetails.Username)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Usuário não encontrado",
		})
		return
	}

	// Comparar a senha com o hash armazenado
	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(loginDetails.Password))
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Senha inválida",
		})
		return
	}

	// Se tudo estiver certo, responder com sucesso
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success": true,
		"message": "Login bem-sucedido",
		"user": map[string]interface{}{
			"id":       user.ID,
			"username": user.Username,
		},
	})
}

