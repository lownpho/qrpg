extends Node

export (int, 1, 20) var cost

export var scalings := {
	"int" : 0,
	"str" : 0,
	"dex" : 0,
	"def" : 0,
	"spd" : 0
}
onready var player = get_parent()

#make it a dictionary so armor can modify more stats
var value : int
export var stat_edit : String

var can_shoot := true

#change accordingly to prev comment
func calculate_value() -> int:
	var d := 0
	for s in scalings:
		d += player.stats.get(s) * scalings[s]
	return d

func _ready():
	Events.connect("base_stat_changed", self, "_on_stat_change")

func _physics_process(delta):
	if Input.is_action_pressed("spell") and can_shoot and player.stats.get("curr_mp")>=cost:
		$duration.start()
		$cd.start()
		can_shoot = false
		value = calculate_value()
		player.stats.add_base("curr_mp", -cost)
		player.stats.add_mod(name, {stat_edit : value})

func _on_stat_change(stat_name, val) -> void:
	value = calculate_value()

func _on_tree_exiting():
	player.stats.remove_mod(name)


func _on_duration_timeout():
	player.stats.remove_mod(name)


func _on_cd_timeout():
	can_shoot = true
