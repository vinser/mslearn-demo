package main

import "fmt"

var version, buildTime, target, goversion string

func main() {
	fmt.Println("Hello maker!")
	fmt.Printf("Version: %s (%s)\n", version, target)
	fmt.Printf("Build time: %s\n", buildTime)
	fmt.Printf("Golang version: %s\n", goversion)
}
