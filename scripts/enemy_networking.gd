extends Node


var sync_health: int:
	set(value):
		sync_health = value
		processed_health = false

var processed_health: bool = false
