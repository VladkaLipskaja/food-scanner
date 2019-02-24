package cmd

import (
	"fmt"
	"scanner/internal/models"
	"scanner/internal/router"
)

/*Execute for */
func Execute() {
	models.GetDB()
	router.NewRouter()
	fmt.Println("aaa2")
}
