extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		body.collect_coins()
		queue_free()
