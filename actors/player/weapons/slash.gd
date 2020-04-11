extends Area2D


func _ready():
	$Timer.connect("timeout", self, "_on_timeout")

func try_activate(rot) -> void:
	if $Timer.is_stopped():
		rotation = rot
		$Timer.start()
		monitoring = true
		monitorable = true
	
	$Sprite.show()

func _on_timeout() -> void:
	monitoring = false
	monitorable = false
	
	$Sprite.hide()
