package models

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

type Language struct {
	gorm.Model
	Name         string
	Translations []LanguageToIngredient
}

func GetLanguages() ([]*Language, error) {

	languages := make([]*Language, 0)

	err := GetDB().Find(&languages).Error
	if err != nil {
		fmt.Println(err)
		return nil, err
	}

	return languages, err
}
