package main

import (
	"crypto/fips140"
	"fmt"
	"os"
	"runtime"
)

func main() {
	fmt.Println("Go version:", runtime.Version())
	fmt.Println("GODEBUG:", os.Getenv("GODEBUG"))
	fmt.Println("FIPS enabled:", fips140.Enabled())
	fmt.Println("Binary started successfully")
}
