package main

import (
	"crypto/fips140"
	"crypto/tls"
	"fmt"
	"net/http"
	"os"
	"runtime"

	_ "github.com/argoproj/argo-workflows/v3/workflow/common"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	fmt.Println("Go version:", runtime.Version())
	fmt.Println("GODEBUG:", os.Getenv("GODEBUG"))
	fmt.Println("FIPS enabled:", fips140.Enabled())

	_ = &tls.Config{MinVersion: tls.VersionTLS12}
	_ = &http.Client{}

	fmt.Println("Binary started successfully")
}
