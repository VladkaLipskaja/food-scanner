package conf

import (
	"os"
)

type DBConfig struct {
	Host string
	Name string
	Port string
	User string
}

func SetDBConfig() DBConfig {
	var config DBConfig

	config.User = os.Getenv("db_user")
	config.Port = os.Getenv("db_port")
	config.Name = os.Getenv("db_name")
	config.Host = os.Getenv("db_host")

	return config
}
