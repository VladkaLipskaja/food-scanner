package router

import (
	"fmt"
	"net/http"
	"scanner/internal/handlers"

	"github.com/gorilla/mux"
)

func NewRouter() {

	router := mux.NewRouter()

	router.HandleFunc("/ingredient/language/{languageID}/search/{search}", handlers.GetIngredients).Methods("GET")
	router.HandleFunc("/ingredient/{barcode}", handlers.GetIngredientsByBarcode).Methods("GET")
	router.HandleFunc("/ingredient", handlers.GetTopIngredients).Methods("GET")
	router.HandleFunc("/language", handlers.GetLanguages).Methods("GET")

	fmt.Println("router")

	port := "8000" //localhost

	fmt.Println(port)

	err := http.ListenAndServe(":"+port, router) //Launch the app, visit localhost:8000/api
	if err != nil {
		fmt.Print(err)
	}
}
