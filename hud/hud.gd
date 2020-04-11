extends CanvasLayer


func _ready():
	Events.connect("stat_changed", self, "_on_stat_changed")

func _on_stat_changed(name, value) -> void:
	get_node("VBoxContainer/"+name).set_text(name + ": " + str(value))
