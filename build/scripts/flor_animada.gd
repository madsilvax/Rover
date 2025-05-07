extends Node3D

@onready var animator: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animator.play("FLOR DESCENDO")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		animator.play("FLOR SUBINDO")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "player":
		animator.play("FLOR DESCENDO")
