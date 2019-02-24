package models

import "github.com/jinzhu/gorm"

type Product struct {
	gorm.Model
	Barcode      string
	IDIngredient string
}

func (Product) TableName() string {
	return "barcode_to_ingredient"
}
