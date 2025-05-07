extends Node3D

@onready var gameover: Control = $gameover
@onready var fim: Control = $fim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_zone_body_entered(body: Node3D) -> void:
	if body.name == "player":
		gameover.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_end_zone_body_entered(body: Node3D) -> void:
	if body.name == "player":
		fim.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
