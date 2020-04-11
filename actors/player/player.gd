class_name Player
extends KinematicBody2D

export var stats : Resource

func _ready():
	stats.initialize()
	randomize()

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		stats.xpup(740)
