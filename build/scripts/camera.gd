extends Node3D

@export var sensi := 0.2
@export var aceleracao := 10

const min := -300
const max := 250

var cam_hor := 0.0
var cam_ver := 0.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam_hor -= event.relative.x * sensi
		cam_ver -= event.relative.y * sensi

func _physics_process(delta: float) -> void:
	cam_ver = clamp(cam_ver, min, max)
	$horizontal.rotation_degrees.y = lerp($horizontal.rotation_degrees.y, cam_hor, aceleracao * delta)
	$horizontal/vertical.rotation_degrees.x = lerp($horizontal.rotation_degrees.x, cam_ver, aceleracao * delta)
