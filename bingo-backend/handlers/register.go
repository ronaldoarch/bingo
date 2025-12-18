package handlers

import (
	"encoding/json"
	"net/http"

	"bingo-backend/db"
	"bingo-backend/models"
	"bingo-backend/utils"
)

func Register(w http.ResponseWriter, r *http.Request) {
	// Garantir que Content-Type está definido
	w.Header().Set("Content-Type", "application/json")
	
	var registerData models.LoginDetails

	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&registerData)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Erro na leitura do corpo da requisição",
		})
		return
	}

	// Validar campos obrigatórios
	if registerData.Username == "" || registerData.Password == "" {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Username e senha são obrigatórios",
		})
		return
	}

	// Verificar se o usuário já existe
	_, err = db.GetUserByUsername(registerData.Username)
	if err == nil {
		// Usuário já existe
		w.WriteHeader(http.StatusConflict)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Usuário já existe",
		})
		return
	}

	// Gerar hash da senha
	hashedPassword, err := utils.GeneratePasswordHash(registerData.Password)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Erro ao processar senha",
		})
		return
	}

	// Criar novo usuário
	user, err := db.CreateUser(registerData.Username, hashedPassword)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"success": false,
			"message": "Erro ao criar usuário",
		})
		return
	}

	// Responder com sucesso
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success": true,
		"message": "Usuário criado com sucesso",
		"user": map[string]interface{}{
			"id":       user.ID,
			"username": user.Username,
		},
	})
}

