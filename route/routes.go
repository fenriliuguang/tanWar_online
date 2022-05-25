package route

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func Setup() *gin.Engine {

	r := gin.New()

	r.LoadHTMLGlob("static/*.html")
	r.Static("/images", "./static/images")
	r.Static("/hilo", "./static/hilo")
	r.Static("/src", "./static/src")
	r.StaticFile("/tankWar.css", "./static/tankWar.css")
	r.StaticFile("/config.js", "./static/config.js")
	r.GET("/index", func(c *gin.Context) {
		c.HTML(http.StatusOK, "index.html", gin.H{})
	})

	return r
}
