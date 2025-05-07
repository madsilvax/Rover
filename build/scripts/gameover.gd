extends Control

func _on_tentar_novamente_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_sair_do_jogo_pressed() -> void:
	get_tree().quit()
