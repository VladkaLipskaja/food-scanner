package models

import "github.com/jinzhu/gorm"

type LanguageToIngredient struct {
	gorm.Model
	IDLanguage   uint
	IDIngredient uint
	Name         string
}

func (LanguageToIngredient) TableName() string {
	return "language_to_ingredient"
}
