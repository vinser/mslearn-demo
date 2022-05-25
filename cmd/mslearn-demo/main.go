package main

import "fmt"

var version, buildTime, builder, goversion string

func main() {
	fmt.Println("Hello maker!")
	fmt.Printf("Version: %s\n", version)
	fmt.Printf("Build time: %s\n", buildTime)
	fmt.Printf("Builded by: %s\n", builder)
	fmt.Printf("Golang ver.%s\n", goversion)
}
