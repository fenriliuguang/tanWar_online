package main

import "web/route"

func main() {
	r := route.Setup()

	r.Run(":8080")
}
