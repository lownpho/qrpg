extends Node

export var base_speed := 75
var _dex_multiplier := 2
var _speed : int
var velocity := Vector2.ZERO

var player : KinematicBody2D


func _ready() -> void:
	Events.connect("stat_changed", self, "_stat_changed")
	player = owner
	_speed = base_speed + player.stats.get("dex") * _dex_multiplier
#	yield(owner, "ready")

func _physics_process(_delta: float) -> void:
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	velocity = player.move_and_slide(_speed*dir.normalized())

func _stat_changed(name:String, val:int) -> void:
	print("stat changed: ", name, " ", val)
	if name == "dex":
		_speed = base_speed + player.stats.get("dex") * _dex_multiplier
		print (_speed)
	
