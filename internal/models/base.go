package models

import (
	"fmt"
	"scanner/food-scanner/internal/conf"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/joho/godotenv"
)

var db *gorm.DB //database

func init() {

	e := godotenv.Load() //Load .env file
	if e != nil {
		fmt.Print(e)
	}

	config := conf.SetDBConfig()

	dbUri := fmt.Sprintf("host=%s port=%s user=%s dbname=%s sslmode=disable", config.Host, config.Port, config.User, config.Name) //Build connection string
	fmt.Println(dbUri)

	conn, err := gorm.Open("postgres", dbUri)

	if err != nil {
		fmt.Print(err)
	}

	db = conn
	db.Debug().AutoMigrate(&Product{}, &Ingredient{}, &LanguageToIngredient{}, &Language{}) //Database migration
	var ingredient Ingredient
	conn.Last(&ingredient)
	fmt.Println(ingredient)
}

//returns a handle to the DB object
func GetDB() *gorm.DB {
	return db
}
