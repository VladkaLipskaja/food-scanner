package cmd

import (
	"fmt"
	"scanner/food-scanner/internal/models"
	"scanner/food-scanner/internal/router"
)

/*Execute for */
func Execute() {
	models.GetDB()
	router.NewRouter()
	fmt.Println("aaa2")
}
