extends Node


var sync_position : Vector2:
	set(value):
		sync_position = value
		processed_position = false

var processed_position : bool
