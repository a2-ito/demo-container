package main

import (
	"os"
	"net/http"
	"github.com/labstack/echo"
)

func main() {
	ENV := os.Getenv("ENV")
	if ENV == "" {
		ENV = "red"
	}
	e := echo.New()
	e.GET("/sample", func(c echo.Context) error {
		return c.JSON(
			http.StatusOK,
			struct {
				Code int    `json:"code"`
				Text string `json:"text"`
			}{
				Code: http.StatusOK,
				Text: http.StatusText(http.StatusOK),
			},
		)
	})
	e.GET("/app", func(c echo.Context) error {
		return c.JSON(
			http.StatusOK,
			struct {
				Code int    `json:"code"`
				Text string `json:"text"`
			}{
				Code: http.StatusOK,
				Text: ENV,
			},
		)
	})
	e.Logger.Fatal(e.Start(":8080"))
}
