class_name Player
extends KinematicBody2D

onready var stats = $stats


var armor

func _ready():
	randomize()
	yield(owner, "ready")
	stats.xpup(3000)
	Events.connect("base_stat_changed", self, "_on_base_stat_changed")

func _physics_process(delta):
	#debug
	if Input.is_action_just_pressed("attack"):
		pass
	if Input.is_action_just_pressed("spell"):
		pass
	if Input.is_action_just_pressed("hppot"):
		pass
	if Input.is_action_just_pressed("mppot"):
		pass

#maybe move it into stats someday
func take_damage(dmg:int) -> void:
	var taken = stats.get("def") - dmg
	if taken < 0:
		stats.add_base("curr_hp", taken)
		pass
	else:
		stats.add_base("curr_hp", -1)
		pass
	Events.emit_signal("player_damaged", stats.get("curr_hp"))
	if  stats.get("curr_hp") <= 0:
		Events.emit_signal("player_dead")
		queue_free()

func consume_mp(cost:int) -> void:
	if cost < stats.get("curr_mp"):
		stats.add_base("curr_mp", -cost)

func _on_base_stat_changed(name, value) -> void:
	#just in case
	pass
