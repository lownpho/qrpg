extends Weapon

var slash : Area2D

func _ready():
	slash = $slash
	slash.connect("body_entered", self, "_on_body_entered")
	
func _physics_process(delta):
	if Input.is_action_pressed("attack") and $cd.is_stopped():
		var rot = PI/2+gen_dir().angle()
		slash.try_activate(rot)
		$cd.start()

func _on_body_entered(body:Node) -> void:
	print(body.name)
