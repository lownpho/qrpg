class_name Stats
extends Resource

export (String) var name
export (String) var description

var base := {
	"hp" : 1,
	"mp" : 1,
	"vit" : 1,
	"wis" : 1,
	"int" : 1,
	"str" : 1,
	"dex" : 1,
	"def" : 1,
	"spd" : 1,
	
	"lv" : 1,
	"exp" : 0
}

export var scalings = {
	"hp" : 1,
	"mp" : 1,
	"vit" : 1,
	"wis" : 1,
	"int" : 1,
	"str" : 1,
	"dex" : 1,
	"def" : 1,
	"spd" : 1,
} #should remove lv and exp but meh

var mods := {}

func add_base(name:String, value:int) -> void:
	base[name] += value
	Events.emit_signal("stat_changed", name, get(name))

func get_base(name:String) -> int:
	return base[name]

#mods stuff
func add_mod(mod_name:String, mod:Dictionary) -> void:
	mods[mod_name] = mod
	for s in mod:
		Events.emit_signal("stat_changed", s, get(s))

func remove_mod(mod_name:String) -> void:
	var updates = []
	for n in mods[mod_name]:
		updates.push_back(n)
	mods.erase(mod_name)
	for n in updates:
		Events.emit_signal("stat_changed",n , get(n))

func get(name:String) -> int:
	var tot = base[name]
	for n in mods:
		if mods[n].has(name):
			tot += mods[n][name]
	return tot

#xp stuff
func xpup(value:int) -> void:
	add_base("exp", value)
	while base["exp"] >= _get_exp_needed_to_lv():
		_levelup()

func _levelup() -> void:
	add_base("lv", 1)
	for s in scalings:
		add_base(s, randi() % (scalings[s]+1))

func _get_exp_needed_to_lv() -> int:
	return int(pow(base["lv"], 3))

func initialize() -> void:
	for s in base:
		Events.emit_signal("stat_changed", s , get(s))
