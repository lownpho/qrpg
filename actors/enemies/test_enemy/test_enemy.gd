extends KinematicBody2D

var max_hp := 30
var curr_hp := max_hp
onready var def = randi()%3+8

var dir := Vector2.ZERO

func _ready():
	pass

func take_damage(damage) -> void:
	var dmg = damage-def
	if dmg > 0:
		curr_hp = int(clamp(curr_hp-dmg, 0, max_hp))
		print(name + "takes " + str(damage) + " damage and has " + str(curr_hp) + " hp")
		$dmg_label.activate(dmg)
		
		
	if curr_hp <= 0:
		die()

func die() -> void:
	queue_free()
