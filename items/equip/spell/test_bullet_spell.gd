extends Node

export (int, 1, 20) var cost
export(PackedScene) var bullet_scn

export var scalings := {
	"int" : 0,
	"str" : 0,
	"dex" : 0,
	"def" : 0,
	"spd" : 0
}
onready var player = get_parent()

export var damage : int
export var speed : int

var can_shoot := true

func calculate_damage() -> int:
	var d := 0
	for s in scalings:
		d += player.stats.get(s) * scalings[s]
	return d

func throw_spell() -> void:
	var b = bullet_scn.instance()
	var d = player.global_position.direction_to(player.get_global_mouse_position())
	b.damage = calculate_damage()
	b.speed = speed
	b.direction = d
	b.position = player.position
	player.get_parent().add_child(b)
	can_shoot = false
	$cooldown.start()

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("spell") and can_shoot and player.stats.get("curr_mp")>=cost:
		player.stats.add_base("curr_mp", -cost)
		throw_spell()

func _on_bullet_spell_tree_exiting():
	pass


func _on_cooldown_timeout():
	can_shoot = true
