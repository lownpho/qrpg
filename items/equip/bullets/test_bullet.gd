extends KinematicBody2D

var damage : int
var speed : int
var direction : Vector2
func _ready():
	pass

func _physics_process(delta):
	move_and_slide(speed*direction)

func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
