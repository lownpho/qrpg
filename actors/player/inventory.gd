extends Node

var potions = {
	"hp" : 0,
	"mp" : 0
}

export var max_potions := 2

func add_potion(type) -> bool:
	if potions[type] < max_potions:
		potions[type] += 1
		return true
	else:
		return false

func add_item(item_ref) -> bool:
	if item_ref is Potion:
		if potions[item_ref.type] < max_potions:
			potions[item_ref.type] += 1
			Events.emit_signal("item_added", item_ref.type)
			return true
		else:
			return false
	else:
		return false

func _ready():
	pass
