extends CharacterBody2D


var gravity = ProjectSettings.get("physics/2d/default_gravity")
var minimum_distance_for_swipe = 200
var is_clicking = false
var click_starting_position = Vector2.ZERO
var click_ending_position = Vector2.ZERO
var is_jumping = false


var last_spike_collision = null


@export var falling_speed : int = 10
@export var jumping_speed : int = 10
@export var switching_sides_speed : int = 100


@onready var main_scene: Node = $".."
@onready var checker: RayCast2D = $Checker
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_jumping:
		velocity.x -= (gravity * switching_sides_speed) * up_direction.x * delta
	if not is_on_floor() and is_jumping:
		velocity.x -= falling_speed * up_direction.x * delta
	if is_on_floor():
		is_jumping = false
	if Input.is_action_just_pressed("Click"):
		click_starting_position = get_global_mouse_position()
		is_clicking = true
	if Input.is_action_just_released("Click") and not is_jumping:
		click_ending_position = get_global_mouse_position()
		is_clicking = false
		change_floor_direction() if check_for_swipe(click_starting_position, click_ending_position) else jump()
	
	if checker.get_collider():
		if not checker.get_collider().earned:
			checker.get_collider().earned = true
			GameInfo.scored()
			main_scene.change_score_label()
	if get_last_slide_collision() and get_last_slide_collision().get_collider().is_in_group("Spikes"):
		die()
	
	move_and_slide()


func change_floor_direction():
		up_direction *= -1
		velocity = Vector2.ZERO


func check_for_swipe(starting_point: Vector2, ending_point: Vector2):
	var distance_of_swipe = abs(starting_point.distance_to(ending_point))
	return true if distance_of_swipe >= minimum_distance_for_swipe else false


func jump():
	is_jumping = true
	velocity = Vector2.ZERO
	velocity.x += jumping_speed * up_direction.x


func die():
	GameInfo.game_over()
	collision_mask = 0
	velocity = Vector2.ZERO
	animation_player.play("die")
	cpu_particles_2d.set_emitting(true)
	await cpu_particles_2d.finished
	queue_free()
