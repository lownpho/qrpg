extends State

export var speed_max := 40.0
export var acceleration_max := 500

var velocity := Vector2.ZERO
var linear_drag := 0.1

var acceleration := GSAITargetAcceleration.new()

onready var agent := GSAISteeringAgent.new()
onready var player_agent: GSAISteeringAgent

onready var proximity
onready var blend := GSAIBlend.new(agent)
onready var priority := GSAIPriority.new(agent)

var body

func _ready():
	agent.linear_speed_max = speed_max
	agent.linear_acceleration_max = acceleration_max
	agent.bounding_radius = 32
	
	

#func unhandled_input(_event: InputEvent) -> void:
#	pass

func update_agent() -> void:
	agent.position.x = owner.global_position.x
	agent.position.y = owner.global_position.y
	agent.linear_velocity.x = velocity.x
	agent.linear_velocity.y = velocity.y

func build_agent_array() -> Array:
	var prox := []
	for n in get_tree().get_nodes_in_group("test_enemy"):
		prox.push_back(n.find_node("pursue").agent)
	return prox

func physics_process(delta: float) -> void:
	update_agent()
	
	blend.calculate_steering(acceleration)
	
	velocity = (velocity + Vector2(acceleration.linear.x, acceleration.linear.y) * delta).clamped(
		agent.linear_speed_max
	)

	# This applies drag on the agent's motion, helping it to slow down naturally.
	velocity = velocity.linear_interpolate(Vector2.ZERO, linear_drag)

	# And since we're using a KinematicBody2D, we use Godot's excellent move_and_slide to actually
	# apply the final movement, and record any change in velocity the physics engine discovered.
	velocity = owner.move_and_slide(velocity)

func enter(_msg: Dictionary = {}) -> void:
	player_agent = _msg.body.agent
	update_agent()
	
	proximity = GSAIRadiusProximity.new(agent, build_agent_array(), 128)
	var pursue := GSAIPursue.new(agent, player_agent)
	pursue.predict_time_max = .5
	
	var separation = GSAISeparation.new(agent, proximity)
	separation.decay_coefficient = 128
	blend.add(pursue, 1)
	blend.add(separation, 128)
	
#	priority.add(blend)
#	priority.add(separation)

func exit() -> void:
	pass

