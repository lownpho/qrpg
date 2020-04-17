extends Label


func _ready():
	pass

func activate(dmg) -> void:
	show()
	$Timer.start()
	text = "-"+str(dmg)

func _on_Timer_timeout():
	hide()
