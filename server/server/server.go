package server

import (
	"fmt"

	"github.com/gorilla/websocket"
	packets "github.com/ignoxx/godot-go-protobuf-ws/server/packets/shared"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"google.golang.org/protobuf/proto"
)

type Server struct {
	httpServer *echo.Echo
	config     *Config
}

func NewServer(config *Config) *Server {
	return &Server{
		config: config,
	}
}

func (s *Server) Start() error {
	s.httpServer = echo.New()
	s.httpServer.Use(middleware.Logger())
	s.httpServer.Use(middleware.CORS())

	s.httpServer.GET("/health", func(c echo.Context) error {
		return c.String(200, "OK")
	})

	s.httpServer.GET("/ws", func(c echo.Context) error {
		conn, err := upgradeToWebsocket(c)
		if err != nil {
			return err
		}

		for {
			_, msg, err := conn.ReadMessage()
			if err != nil {
				return err
			}

			packetID := msg[0]

			switch packetID {

			case 1: // handle test packet
				packet := packets.Test{}

				if err = proto.Unmarshal(msg[1:], &packet); err != nil {
					return err
				}

				fmt.Println("Received test packet:")
				fmt.Println(packet.Name)
				fmt.Println(packet.Age)
				fmt.Println(packet.Nicknames)

			case 2: // handle login packet
				packet := packets.LoginRequest{}

				if err = proto.Unmarshal(msg[1:], &packet); err != nil {
					return err
				}

				fmt.Println("Received login packet:")
				fmt.Println(packet.Username)
				fmt.Println(packet.Password)
				fmt.Println(packet.Email)

                response := packets.LoginResponse{}
                response.Token = "some-token-here"

                msg, err := proto.Marshal(&response)
                if err != nil {
                    return err
                }

                msg = append([]byte{2}, msg...)

                err = conn.WriteMessage(websocket.BinaryMessage, msg)
                if err != nil {
                    return err
                }

			default:
				fmt.Println("Unknown packet ID: ", packetID)
			}
		}
	})

	return s.httpServer.Start(s.config.addr)
}

func upgradeToWebsocket(c echo.Context) (*websocket.Conn, error) {
	upgrader := websocket.Upgrader{
		ReadBufferSize:  1024,
		WriteBufferSize: 1024,
	}

	conn, err := upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return nil, err
	}

	return conn, nil
}
