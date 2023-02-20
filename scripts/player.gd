class_name Player
extends CharacterBody2D

const SPEED = 50000.0

@onready var Cam = $Camera2D
@onready var Weap = $Weapon
@onready var Networking = $Networking
@onready var Synchronizer = $Networking/MultiplayerSynchronizer


func _ready():
	Synchronizer.set_multiplayer_authority(str(name).to_int())
	
	Cam.enabled = is_local_authority()
	if is_local_authority:
		modulate = Color(randf(), randf(), randf())
		
#	if is_local_authority() && multiplayer.get_unique_id() != 1:
#		Logs.rpc_id(1, "add", "Hello World!", Logs.LVL_DEBUG)


func _physics_process(delta):	
	if !is_local_authority():
		return
		if !Networking.processed_position:
			position = Networking.sync_position
			Networking.processed_position = true
		return
		
	var dir = Vector2()
	dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = dir.normalized() * SPEED * delta
	
	# move locally
	move_and_slide()
	look_at(get_global_mouse_position())
	
	Networking.sync_position = position
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func is_local_authority() -> bool:
	return Synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()


func shoot() -> void:
	Weap.shoot(position, (get_global_mouse_position() - position).normalized())
