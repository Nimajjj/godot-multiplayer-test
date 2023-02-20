class_name Weapon
extends Node2D


var player: Player

var BulletScene: PackedScene = preload("res://scenes/bullet.tscn")


func _ready():
	player = get_parent()


func shoot(pos: Vector2, dir: Vector2) -> void:
	if !player.is_local_authority():
		print("Fucking huge mess somewhere, this should mever happen!")
		return

	shoot_impl(pos, dir)
	rpc_id(1, "shoot_server", pos, dir)
	
	
@rpc("any_peer")
func shoot_server(pos: Vector2, dir: Vector2) -> void:
	var caller_id = multiplayer.get_remote_sender_id()
	if str(player.name).to_int() != caller_id:
		print("Illegally calling shoot_server! The culprit is: " + str(caller_id))
		return

	rpc("shoot_client", pos, dir)


@rpc # Called on _all_ clients
func shoot_client(pos : Vector2, dir: Vector2) -> void:
	if player.is_local_authority(): return
	shoot_impl(pos, dir)


# Handle all the effects (visual & audio)
# This is called on all clients, including the server & the client initiating the shot
func shoot_impl(pos: Vector2, dir: Vector2) -> void:
	var bullet: Bullet = BulletScene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = pos
	bullet.direction = dir
