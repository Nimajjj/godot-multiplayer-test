class_name Server
extends Node

var game: Node
var players: int = 0
var player_scene: PackedScene = preload("res://scenes/player.tscn")


func init(game_node: Node) -> void:	
	game = game_node
	start_network()


func start_network() -> void:
	var peer = ENetMultiplayerPeer.new()
	
	# Listen to peer connections, and create new player for them
	multiplayer.peer_connected.connect(self.create_player)
	# Listen to peer disconnections, and destroy their players
	multiplayer.peer_disconnected.connect(self.destroy_player)
	
	peer.create_server(9999)
	Logs.add('Server listening on 127.0.0.1:9999')

	multiplayer.set_multiplayer_peer(peer)


func create_player(id: int) -> void:
	# Instantiate a new player for this client.
	var player = player_scene.instantiate()

	# Set the name, so players can figure out their local authority
	player.name = str(id)
	
	Logs.add("New player joined [" + str(id) + "]")
	
	game.add_child(player)
	player.global_position.x = players * 500
	player.global_position.y = players * 500
	
	players += 1


func destroy_player(id: int) -> void:
	# Delete this peer's node.
	game.get_node(str(id)).queue_free()
	Logs.add("Player left [" + str(id) + "]")
	
	players -= 1
