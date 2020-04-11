extends Weapon

export var bullet_pck : PackedScene
export var bullet_spd : int
var bullet : KinematicBody2D

func _throw_bullet(dir) -> void:
	bullet = bullet_pck.instance()
	bullet.dir = dir
	bullet.spd = bullet_spd
	player.add_child(bullet)

func _ready():
	$cd.connect("timeout", self, "_on_timeout")

func _physics_process(delta):
	if Input.is_action_pressed("attack") and $cd.is_stopped():
		var dir = gen_dir()
		_throw_bullet(dir)
		$cd.start()

func _input(event):
	pass

func _on_timeout() -> void:
	pass
