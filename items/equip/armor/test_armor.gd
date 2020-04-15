extends Node

export var def_scaling := {
	"int" : 0,
	"str" : 0,
	"dex" : 0,
	"def" : 0,
	"spd" : 0
}
onready var player = get_parent()

var def_bonus : int

#change accordingly to prev comment
func calculate_value() -> int:
	var d := 0
	for s in def_scaling:
		d += player.stats.get_base(s) * def_scaling[s]
	return d

func _ready():
	print(name)
	def_bonus = calculate_value()
	
	#as prev comments
	player.stats.add_mod(name, {"def" : def_bonus})
	Events.connect("base_stat_changed", self, "_on_stat_change")

func _on_stat_change(stat_name, val) -> void:
	def_bonus = calculate_value()
	player.stats.remove_mod(name)
	player.stats.add_mod(name, {"def" : def_bonus})

func _on_armor_tree_exiting():
	player.stats.remove_mod(name)
