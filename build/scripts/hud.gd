extends Control

@onready var coin_label: Label = $coins_container/coin_label

func update_coin(amount: int):
	coin_label.text = "%d" %amount

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$pause.show()
		get_tree().paused = true

func _on_continuar_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$pause.hide()
	get_tree().paused = false

func _on_recomecar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_sair_do_jogo_pressed() -> void:
	get_tree(). quit()
