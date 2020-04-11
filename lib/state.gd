# Use State as a child of a StateMachine node.
# tags: abstract

class_name State
extends Node

onready var _fsm := _get_fsm(self)
#var _parent: State = null

func _ready():
#	yield(owner, "ready")
#	_parent = get_parent() as State
	pass


#func unhandled_input(_event: InputEvent) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func enter(_msg: Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass

func _get_fsm(node: Node) -> Node:
	if node != null and not node.is_in_group("fsm"):
		return _get_fsm(node.get_parent())
	return node
