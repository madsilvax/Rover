extends CharacterBody3D

const speed = 4
const jump_strength = 8
var can_jump = 2
var gravity = 0

const dash_strength = 200000
var can_dash = 1

@onready var personagem: Node3D = $personagem
@onready var animator = get_node("personagem/AnimationPlayer") as AnimationPlayer
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var scan: Node3D = $scan
@onready var animator_scan = get_node("scan/AnimationPlayer") as AnimationPlayer
@onready var scan_box: Area3D = $scan_box

var movement_velocity : Vector3
var knockbacked = false

@onready var hud: Control = $hud
var coins = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if !knockbacked:
		handle_animation()
	apply_gravity(delta)
	jump(delta)
	
	#gravidade
	var applied_velocity : Vector3
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	if !knockbacked:
		velocity = applied_velocity
		var rotacao_horizontal = $camera/horizontal.global_transform.basis.get_euler().y
		var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, rotacao_horizontal)
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			personagem.rotation.y = lerp_angle(personagem.rotation.y, atan2(direction.x, direction.z), delta * 5)
			scan.rotation.y = lerp_angle(scan.rotation.y, atan2(direction.x, direction.z), delta * -5)
			scan_box.rotation.y = lerp_angle(scan_box.rotation.y, atan2(direction.x, direction.z), delta * -5)

		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func _process(_delta)->void: 
	if spring_arm != null:
		spring_arm.position = position
	if is_on_floor():
		can_jump = 2

func handle_animation():
		if is_on_floor():
			if abs(velocity.x) > 1 or abs(velocity.z) > 1:
				animator.play("WALK_001", 0.3)
			else:
				animator.play("IDLE", 0.3)
		else:
			animator.play("JUMP1", 0.3)
		
		if knockbacked:
			animator.play("JUMP 2", 0.3)
		
		if !is_on_floor() and gravity > 2:
			animator.play("JUMP 2", 0.3)
		if Input.is_action_just_pressed("scan"):
			animator_scan.play("PlaneAction", 0.3)

func apply_gravity(delta):
	if !is_on_floor():
		gravity += 25 * delta
	
	if gravity > 0 and is_on_floor():
		gravity = 0

func jump(delta):
	if Input.is_action_just_pressed("jump") and can_jump > 0:
		gravity = -jump_strength
		can_jump -= 1

func dash():
	if Input.is_action_just_pressed("dash"):
		pass

func knockback(impact_point: Vector3, force: Vector3) -> void:
	force.y = abs(force.y)
	velocity = force.limit_length(10)

func _on_hurtbox_body_entered(body: Node3D) -> void:
	if body.name == "inimigo":
		var body_collision = (body.global_position - global_position)
		var force = -body_collision
		force *= 8
		gravity = -5
		knockback(body_collision, force)
		knockbacked = true
		await get_tree().create_timer(0.3).timeout
		knockbacked = false

func collect_coins():
	coins += 1
	hud.update_coin(coins)
