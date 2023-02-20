class_name Enemy
extends CharacterBody2D


const SPEED = 300.0

var health_sync: int = 100
var global_pos_sync: Vector2 = Vector2.ZERO

@onready var HealthBar: ProgressBar = $ProgressBar


func _enter_tree():
	Logs.add(name + " enter tree", Logs.LVL_DEBUG)


func _physics_process(_delta):
	if !multiplayer.is_server():
		global_position = global_position.lerp(global_pos_sync, 0.1)
		return
		
	global_pos_sync = global_position
		

func take_damage(dmg: int) -> void:
	if multiplayer.is_server():
		Logs.add(name + " took damage", Logs.LVL_DEBUG)
		health_sync -= dmg
		_update_health()
	_update_health()
	
		
func _update_health() -> void:
	HealthBar.value = health_sync
	if health_sync <= 0:
		queue_free()


func _on_tree_exiting():
	Logs.add(name + " exit tree", Logs.LVL_DEBUG)
