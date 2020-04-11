class_name ScalableItem
extends Item

export var scalings := {
	"int" : 0,
	"str" : 0,
	"dex" : 0,
	"def" : 0,
	"spd" : 0
}

#questa cosa fa schifo
export var used_player_stats := {}


var value := 0

func _ready():
	Events.connect("stat_changed", self, "_update_damage")
	pass

func _update_value(name, val) -> void:
	used_player_stats[name] = val
	for s in used_player_stats:
		value += used_player_stats[s] * scalings[s]
