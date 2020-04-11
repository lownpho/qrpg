extends KinematicBody2D

var dir := Vector2.ZERO
var spd : int

func _ready():
	$lesser_fireball.connect("body_entered", self, "_on_body_entered")

func _physics_process(delta):
	move_and_slide(spd*dir)

func _on_body_entered(body:Node) -> void:
	print(body.name)
	queue_free()
