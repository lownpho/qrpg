extends State

var spd := 20
onready var velocity := Vector2.ZERO

var body

func _ready():
	owner.dir = Vector2(randi()%3-1,randi()%3-1).normalized()

#func unhandled_input(_event: InputEvent) -> void:
#	pass

func physics_process(_delta: float) -> void:
	velocity = owner.move_and_slide(spd*owner.dir)


func enter(_msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass


func _on_dir_change_timeout():
	owner.dir = Vector2(randi()%3-1,randi()%3-1).normalized()


func _on_player_detect_body_entered(body):
	_fsm.transition_to("pursue", {"body":body})
