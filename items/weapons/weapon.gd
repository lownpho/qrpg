class_name Weapon
extends ScalableItem

#not sure what to do with this, cioè a che cazzo servono?
export (String, "semicircle_long", "semicircle_short", "rectangle") var area_type

export (int, 1, 10) var speed

func _ready():
	pass

func get_damage() -> int:
	return value
