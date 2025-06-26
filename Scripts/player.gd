extends Area2D


@export var rotation_speed = 20
@export var bullet_speed =  20
@export var BULLET_SCENE : PackedScene
@onready var bullet_position: Node2D = $BulletPosition
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var health = 3
var rotation_direction = 0


func _physics_process(delta: float) -> void:
	rotation_degrees += rotation_direction * rotation_speed * delta
	shoot() if Input.is_action_just_pressed("Shoot") else null

func shoot():
	var bullet : RigidBody2D = BULLET_SCENE.instantiate()
	bullet.direction = bullet_speed * Vector2(cos(rotation), sin(rotation))
	bullet.position = bullet_position.global_position
	bullet.rotation_degrees = rotation_degrees
	add_sibling(bullet)


func take_damage():
	health -= 1
	animated_sprite_2d.frame += 1


func lose():
	Engine.time_scale = 0


func _on_right_btn_button_up() -> void:
	rotation_direction = 0


func _on_left_btn_button_up() -> void:
	rotation_direction = 0


func _on_left_btn_button_down() -> void:
	rotation_direction = -1


func _on_right_btn_button_down() -> void:
	rotation_direction = 1


func _on_shoot_button_pressed() -> void:
	shoot()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Asteroids"):
		body.queue_free()
		take_damage()
		if health == 0:
			lose()
