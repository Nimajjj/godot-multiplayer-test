class_name Bullet
extends Area2D

const SPEED: int = 5000

var direction: Vector2 = Vector2()


func _physics_process(delta):
	position += direction * SPEED * delta

	
func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(25)
	
	queue_free() 
