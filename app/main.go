package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

// checking comment for linter
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from Go ECS PoC!\nService: %s\n", "sample-service")
}
func pinghandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}

//nolint:errcheck
func main() {
	go func() {
		for {
			log.Println("Starting server on :8080")
			time.Sleep(10 * time.Second)
		}
	}()
	http.HandleFunc("/", handler)
	http.HandleFunc("/ping", pinghandler)
	http.ListenAndServe(":8080", nil)
}
