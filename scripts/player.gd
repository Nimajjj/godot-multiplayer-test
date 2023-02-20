class_name Player
extends CharacterBody2D

const SPEED = 50000.0

var is_local_authority: bool = false

@onready var Cam = $Camera2D
@onready var Weap = $Weapon
@onready var Synchronizer = $Networking/MultiplayerSynchronizer


func _ready():
	Synchronizer.set_multiplayer_authority(str(name).to_int())
	
	is_local_authority = Synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
	
	Cam.enabled = is_local_authority
	if is_local_authority:
		modulate = Color(randf(), randf(), randf())
		
#	if is_local_authority && multiplayer.get_unique_id() != 1:
#		Logs.rpc_id(1, "add", "Hello World!", Logs.LVL_DEBUG)


func _physics_process(delta):	
	if !is_local_authority: 
		return
		
	var dir = Vector2.ZERO
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = dir.normalized() * SPEED * delta
	
	move_and_slide()
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot() -> void:
	Weap.shoot(position, (get_global_mouse_position() - position).normalized())
