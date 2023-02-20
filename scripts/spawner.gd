extends Node2D

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")


func _ready():
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.name = "Enemy_{0}".format([randf_range(0, 1000000)])
	add_child(enemy, true)


