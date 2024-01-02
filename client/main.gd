extends Control

var TestPacket = preload("res://net/packets/test.gd")
var LoginPacket = preload("res://net/packets/login.gd")

func _init() -> void:
	Net.connect("login_token_updated", self, "on_login_token_update")

func _on_Button_pressed():
	var a = TestPacket.Test.new()
	a.set_name("ignoxx")
	a.set_age(42)
	a.add_nicknames("moonsteroid")
	a.add_nicknames("TopG")
	a.add_nicknames("deez")
	var packed_bytes = a.to_bytes()

	var packet = PoolByteArray()
	packet.append(1)
	packet.append_array(packed_bytes)

	Net.ws.get_peer(1).put_packet(packet)


func _on_LoginRequestBtn_pressed() -> void:
	var req = LoginPacket.LoginRequest.new()
	req.set_username("ignoxx")
	req.set_password("safe-a-f")
	req.set_email("test@test.com")

	var packed_bytes = req.to_bytes()

	var packet = PoolByteArray()
	packet.append(2)
	packet.append_array(packed_bytes)

	Net.ws.get_peer(1).put_packet(packet)

func on_login_token_update(token: String):
	$Label/Value.text = token
