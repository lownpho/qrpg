
class_name Weapon
extends Node2D

var player

func gen_dir() -> Vector2:
	var d = player.global_position.direction_to(get_global_mouse_position())
	return d

func _ready():
	player = get_parent()
