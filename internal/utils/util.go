package utils

import (
	"encoding/json"
	"net/http"
)

func Message(status bool, errors []string) map[string]interface{} {
	return map[string]interface{}{"result": status, "errors": errors}
}

func Respond(w http.ResponseWriter, data map[string]interface{}) {
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(data)
}
