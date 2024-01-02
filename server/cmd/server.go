package main

import "github.com/ignoxx/godot-go-protobuf-ws/server/server"

func main() {
	serverConfig := server.NewConfig().
		WithAddr(":3000")

    server := server.NewServer(serverConfig)
    server.Start()
}
