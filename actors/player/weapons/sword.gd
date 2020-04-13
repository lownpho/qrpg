class_name Sword
extends Area2D

export (float, 0.1, 2,  0.1) var cooldown

var can_attack := true

export var scalings := {
	"int" : 0,
	"str" : 0,
	"dex" : 0
}

var damage : int
onready var player = get_parent()

func _ready():
	connect("body_entered", self, "_on_body_entered")
	$cd.wait_time = cooldown
	$cd.connect("timeout", self, "_on_cd_timeout")
	$uptime.connect("timeout", self, "_on_uptime_timeout")

func _physics_process(delta) -> void:
	if can_attack and Input.is_action_pressed("attack"):
		_attack()
	var d = player.global_position.direction_to(get_global_mouse_position())
	rotation = d.angle() + PI/2
	
func _attack() -> void:
	$cd.start()
	$uptime.start()
	$Sprite.visible = true
	can_attack = false
	monitoring = true
	
	damage = calculate_damage()
	

func calculate_damage() -> int:
	var d := 0
	for s in scalings:
		d += player.stats.get(s) * scalings[s]
	return d

func _on_body_entered(body) -> void:
	print(body.name)
	

func _on_cd_timeout() -> void:
	can_attack = true

func _on_uptime_timeout() -> void:
	monitoring = false
	$Sprite.visible = false
