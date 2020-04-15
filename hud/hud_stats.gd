extends GridContainer


func _ready():
	Events.connect("base_stat_changed", self, "_on_stat_changed")
	Events.connect("stat_demodded", self, "_on_stat_changed")
	Events.connect("stat_modded", self, "_on_stat_changed")

func _on_stat_changed(stat, value) -> void:
	if find_node(stat) != null:
		get_node(stat).text = stat + ": " + str(value)
