extends CanvasLayer


func _ready():
	Events.connect("base_stat_changed", self, "_on_base_stat_changed")
	Events.connect("stat_modded", self, "_on_stat_modded")
	Events.connect("stat_demodded", self, "_on_stat_demodded")
	Events.connect("player_damaged", self, "_on_player_damage_taken")

#implement in future
func _on_stat_modded(name, value) -> void:
	_on_base_stat_changed(name, value)

func _on_stat_demodded(name, value) -> void:
	_on_base_stat_changed(name, value)

func _on_base_stat_changed(name, value) -> void:
	if $VBoxContainer.find_node(name) != null:
		get_node("VBoxContainer/"+name).set_text(name + ": " + str(value))
	else:
		if name == "max_hp":
			$VBoxContainer/hp_bar.max_value = value
		elif name == "max_mp":
			$VBoxContainer/mp_bar.max_value = value
		elif name == "curr_hp":
			$VBoxContainer/hp_bar.value = value
		elif name == "curr_mp":
			$VBoxContainer/mp_bar.value = value
		
	

func _on_player_damage_taken(value) -> void:
	$VBoxContainer/hp_bar.value = value
