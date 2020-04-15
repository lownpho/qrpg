extends Node

var player

var item_dirs := {
	"armor" : "res://items/equip/armor/",
	"spell" : "res://items/equip/spell/",
	"weapon" : "res://items/equip/weapon/"
}

var active := { 
	#armor, weapon, spell
}

var stock := {
	"slot0" : "",
	"slot1" : "",
	"slot2" : "",
	"slot3" : "",
	"slot4" : "",
	"slot5" : "",
	"slot6" : "",
	"slot7" : ""
}

var pck_database = {}

func _ready():
	_populate_database()
	player = get_parent()

func _populate_database() -> void:
	for n in item_dirs:
		var tmpdict := {}
		var dir := Directory.new()
		if dir.open(item_dirs[n]) == OK:
			dir.list_dir_begin()
			var file = dir.get_next()
			while file != "":
				if file.get_extension() == "tscn":
					var scn_name = file
					scn_name.erase(file.length()-5, 5)
					tmpdict[scn_name] = load(item_dirs[n]+file)
				file = dir.get_next()
			dir.list_dir_end()
		pck_database[n] = tmpdict

#FIND A WAY TO REMOVE ITEM_SLOT!!! (retrieve it from somewhere)
func activate(item_slot, item_name) -> void:
	if !active.has(item_slot):
		active[item_slot] = pck_database[item_slot][item_name].instance()
		player.add_child(active[item_slot])
		Events.emit_signal("item_activated", item_slot, active[item_slot].name)

func deactivate(item_slot) -> void:
	if active.has(item_slot):
		Events.emit_signal("item_deactivated", item_slot, active[item_slot].name)
		active[item_slot].queue_free()
		active.erase(item_slot)

func find_empty_stock_slot() -> String:
	for s in stock:
		if stock[s] == "":
			return s
	return ""

func stock(item_name) -> void:
	var target_slot := find_empty_stock_slot()
	if target_slot != "":
		stock[target_slot] = item_name
		Events.emit_signal("item_stocked")

func destock_by_slot(stock_slot) -> void:
	if stock[stock_slot] != "":
		Events.emit_signal("item_destocked", stock_slot, stock[stock_slot])
		stock[stock_slot] = ""

func active_to_stock(active_slot) -> void:
	#be really sure you can do it
	if active.has(active_slot) and (find_empty_stock_slot() != ""):
		stock(active[active_slot].name)
		deactivate(active_slot)

func stock_to_active(stock_slot, active_slot):
	if active.has(active_slot):
		active_to_stock(active_slot)
	activate(active_slot, stock[stock_slot])
	destock_by_slot(stock_slot)
