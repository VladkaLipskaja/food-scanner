package models

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

type Ingredient struct {
	gorm.Model
	Description  string
	Counter      uint
	Translations []LanguageToIngredient
	Product      []Product    `gorm:"many2many:barcode_to_ingredient;"`
	Ingredients  []Ingredient `gorm:"many2many:ingredient_to_ingredient;"`
}

func GetIngredientsByBarcode(barcode string) ([]*Ingredient, error) {

	ingredients := make([]*Ingredient, 0)

	err := GetDB().Joins("JOIN barcode_to_ingredient ON barcode_to_ingredient.id_ingredient = ingredients.id AND barcode_to_ingredient.barcode like ?", string("%"+barcode+"%")).Find(&ingredients).Error
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return ingredients, err
}

func GetIngredients(search string, languageId int) ([]*LanguageToIngredient, error) {

	ingredients := make([]*Ingredient, 0)
	db := GetDB()
	err := db.Joins("JOIN language_to_ingredient ON language_to_ingredient.id_language = ingredients.id AND language_to_ingredient.id_language = ?", languageId).Find(&ingredients).Error

	if err != nil {
		return nil, err
	}

	for _, ingredient := range ingredients {
		ingredient.Counter = ingredient.Counter + 1
		db.Save(&ingredient)
	}

	languageIngredients := make([]*LanguageToIngredient, 0)
	err = db.Joins("JOIN ingredients ON language_to_ingredient.id_language = ingredients.id AND language_to_ingredient.id_language = ?", languageId).Find(&languageIngredients).Error

	if err != nil {
		return nil, err
	}

	return languageIngredients, err
}
