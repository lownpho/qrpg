extends Node

export var base_speed := 50
var _spd_multiplier = 2
var _speed : int
var velocity := Vector2.ZERO

var player : KinematicBody2D


func _ready() -> void:
	Events.connect("base_stat_changed", self, "_on_base_stat_changed")
	Events.connect("stat_modded", self, "_on_base_stat_changed")
	Events.connect("stat_demodded", self, "_on_base_stat_changed")
	player = owner
	yield(player, "ready")
	_speed = base_speed + player.stats.get("spd") * _spd_multiplier

func _physics_process(_delta: float) -> void:
	var dir = Vector2.ZERO
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	velocity = player.move_and_slide(_speed*dir.normalized())
	update_agent()

func _on_base_stat_changed(name:String, val:int) -> void:
	if name == "spd":
		_speed = base_speed + player.stats.get("spd") * _spd_multiplier
		player.agent.linear_speed_max = _speed

func update_agent() -> void:
	player.agent.position.x = player.global_position.x
	player.agent.position.y = player.global_position.y
	player.agent.linear_velocity.x = velocity.x
	player.agent.linear_velocity.y = velocity.y
