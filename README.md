# Godot-Go Multiplayer Project Template

Jumpstart your multiplayer project with our Godot-Go Protobuf-Websocket template. This template is designed to provide a solid foundation for your multiplayer game development, leveraging the power of Godot, Go, Protobuf, and Websockets.

## Prerequisites

To get started with this template, you will need the following installed on your system:

- [Godot v3.5](https://godotengine.org/download) (We are currently using v3.5 as the web export feature in v4 is not yet on par with v3.5)
- Protoc: Install it using the following command:
```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
```
- Make: This is usually pre-installed on Linux/Mac systems. If not, refer to your system's package manager to install it.

## Getting Started

To get started with this template, clone the repository and install the necessary dependencies. Then, you can begin developing your multiplayer game. Happy coding!

### (Re)Generate protobuf files for client and server
```sh
make generate # to generate both

##

make generate-client

##

make generate-server

```

## Tech Choices

We have chosen Godot, Go, Protobuf, and Websockets for this template due to their efficiency, flexibility, and compatibility with web exports. These technologies provide a robust foundation for developing multiplayer games.

## Why Protobuf?

Protobuf, or Protocol Buffers, is a method of serializing structured data. It's a flexible, efficient, and automated mechanism for serializing structured data – think XML, but smaller, faster, and simpler. 

By using Protobuf, we can define our packets once and reuse them in our server and client in a type-safe way. This not only reduces the likelihood of errors but also makes the process more efficient. Protobuf is a superior choice over JSON for this purpose, as it eliminates the need to manually write your bytes in order and prevents human errors.

## Contributing

We welcome contributions to this template. If you have a feature request, bug report, or proposal for improvement, please open an issue on GitHub. We appreciate your help in making this template better.
