extends Node3D

@onready var animator = get_node("cristal/AnimationPlayer") as AnimationPlayer
@onready var timer: Timer = $Timer

var cristal_ativo = false

func _process(delta: float) -> void:
	if cristal_ativo == true:
		animator.play("cristal_on")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		animator.play("cristal_off")
		$Area3D.queue_free()
		timer.start()

func _on_timer_timeout() -> void:
	cristal_ativo = true
