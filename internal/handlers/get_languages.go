package handlers

import (
	"net/http"
	"scanner/internal/models"
	u "scanner/internal/utils"
)

func GetLanguages(w http.ResponseWriter, r *http.Request) {
	data, err := models.GetLanguages()
	var resp map[string]interface{}
	if err != nil {
		resp = u.Message(false, []string{err.Error()})
	} else {
		resp = u.Message(true, []string{})
	}
	resp["data"] = data
	u.Respond(w, resp)
}
