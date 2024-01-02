extends Node

signal login_token_updated

var ws = WebSocketClient.new()
var url = "ws://127.0.0.1:3000/ws"

var LoginPacket = preload("res://net/packets/login.gd")

func _ready():
	ws.connect("connection_established", self, "_connection_established")
	ws.connect("connection_closed", self, "_connection_closed")
	ws.connect("connection_error", self, "_connection_error")
	ws.connect("data_received", self, "_connection_data")

	print("Connection to ", url)
	var err = ws.connect_to_url(url)

	if err != OK:
		print("failed to connect to server " + str(err))

func _connection_established():
	print("connection established")

func _connection_closed():
	print("connection closed")

func _connection_error():
	print("connection error")

func _connection_data():
	while ws.get_peer(1).get_available_packet_count() > 0:
		var packet = ws.get_peer(1).get_packet()

		var packet_id = packet[0]
		var packet_data = packet.subarray(1, packet.size()-1)

		match packet_id:
			2: # login request
				var res = LoginPacket.LoginResponse.new()
				var result_code = res.from_bytes(packet_data)
				if result_code != LoginPacket.PB_ERR.NO_ERRORS:
					print("failed to unpack packet")

				emit_signal("login_token_updated", res.get_token())

func _process(delta):
	ws.poll()
