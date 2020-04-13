extends Node

export (String) var armor_name 

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

#change accordingly to prev comment
func calculate_value() -> int:
	var d := 0
	for s in scalings:
		d += player.stats.get(s) * scalings[s]
	return d

func _ready():
	Events.connect("base_stat_changed", self, "_on_stat_change")
	value = calculate_value()
	
	#as prev comments
	player.stats.add_mod(armor_name, {"def" : value})

func _on_stat_change(name, val) -> void:
	value = calculate_value()

func _on_armor_tree_exiting():
	player.stats.remove_mod(armor_name)
