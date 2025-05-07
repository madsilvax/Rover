extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://build/scenes/world.tscn")
