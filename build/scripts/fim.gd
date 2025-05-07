extends Control

func _on_menu_inicial_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://build/scenes/tela inicial.tscn")

func _on_sair_do_jogo_pressed() -> void:
	get_tree().quit()
