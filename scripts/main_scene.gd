extends Node2D


var server_scene: PackedScene = preload("res://scenes/server.tscn")
var client_scene: PackedScene = preload("res://scenes/client.tscn")


func _ready():
	Logs.headless = "--headless" in OS.get_cmdline_args() # don't work for some mysterious reasons
	
	if "--server" in OS.get_cmdline_args():
		var server: Server = server_scene.instantiate()
		add_child(server)
		server.init($Game)
		
		if multiplayer.is_server():
			var enemy = preload("res://scenes/enemy.tscn").instantiate()
			$Mobs.add_child(enemy, true)
		
	else:
		var client: Client = client_scene.instantiate()
		add_child(client)
		client.start_network()
