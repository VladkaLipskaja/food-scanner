package handlers

import (
	"fmt"
	"net/http"
	"scanner/food-scanner/internal/models"
	u "scanner/food-scanner/internal/utils"
	"strconv"

	"github.com/gorilla/mux"
)

func GetIngredientsByBarcode(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	data, err := models.GetIngredientsByBarcode(vars["barcode"])
	var resp map[string]interface{}
	if err != nil {
		resp = u.Message(false, []string{err.Error()})
	} else {
		resp = u.Message(true, []string{})
	}
	resp["data"] = data
	u.Respond(w, resp)
}

func GetIngredients(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, ok := strconv.Atoi(vars["languageID"])
	if ok != nil {
		fmt.Println(ok)
	}
	data, err := models.GetIngredients(vars["search"], id)
	var resp map[string]interface{}
	if err != nil {
		resp = u.Message(false, []string{err.Error()})
	} else {
		resp = u.Message(true, []string{})
	}
	resp["data"] = data
	u.Respond(w, resp)
}

func GetAllIngredients(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, ok := strconv.Atoi(vars["languageID"])
	if ok != nil {
		fmt.Println(ok)
	}
	data, err := models.GetAllIngredients(id)
	var resp map[string]interface{}
	if err != nil {
		resp = u.Message(false, []string{err.Error()})
	} else {
		resp = u.Message(true, []string{})
	}
	resp["data"] = data
	u.Respond(w, resp)
}
