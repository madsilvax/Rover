extends CharacterBody3D

const speed = 2
const chase_range := 4.0
const attack_range := 1

@export var target : CharacterBody3D
@onready var nav_agent: NavigationAgent3D = $nav_agent
@onready var animation_tree: AnimationTree = $beetlebot/beetle_bot_skin/AnimationTree as AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	match state_machine.get_current_node():
		"idle":
			look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
		"walk":
			if global_position.distance_to(target.global_position) < chase_range:
				nav_agent.set_target_position(target.global_transform.origin)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_transform.origin). normalized() * speed * delta * 600
				look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
		"headbutt":
			look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
	
	animation_tree.set("parameters/conditions/walk", chase_player())
	animation_tree.set("parameters/conditions/idle", not chase_player())
	animation_tree.set("parameters/conditions/headbutt", attack_player())
	
	move_and_slide()

func chase_player():
	return global_position.distance_to(target.global_position) < chase_range

func attack_player():
	return global_position.distance_to(target.global_position) < attack_range
