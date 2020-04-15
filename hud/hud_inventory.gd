extends VBoxContainer
#signal item_activated(item_name, slot)
#signal item_deactivated(item_name, slot)
#signal item_destocked(item_name, slot)
#signal item_stocked(item_name, slot)

func _ready():
	Events.connect("item_activated", self, "item_activated")
	Events.connect("item_deactivated", self, "item_deactivated")
	Events.connect("item_stocked", self, "item_stocked")
	Events.connect("item_destocked", self, "item_destocked")
	
func item_activated(slot, item_name):
	get_node("active/"+slot).text = item_name
func item_deactivated(slot, item_name):
	get_node("active/"+slot).text = "empty"
func item_destocked(slot, item_name):
	get_node("stock/"+slot).text = "empty"
func item_stocked(slot, item_name):
	get_node("stock/"+slot).text = item_name
