extends Node


var score = 0
@onready var score_label: Label = $GUI/Control/ScoreTextureRect/ScoreLabel

const DEBREE = preload("res://Scenes/Space/debree.tscn")
const BULLET_DEBREE = preload("res://Scenes/Space/bullet_debree.tscn")
const ICE_DEBREE = preload("res://Scenes/Space/ice_debree.tscn")

@onready var cam = $Camera2D
@onready var screen_size = get_viewport().size
@onready var top_edge = cam.global_position.y - screen_size.y * 0.5 * cam.zoom.y
@onready var left_edge = cam.global_position.x - screen_size.x * 0.5 * cam.zoom.x
@onready var inner_circle: Sprite2D = $GUI/Control/OuterCircle/InnerCircle
@onready var retry_button_texture: TextureRect = $GUI/Control/OuterCircle/InnerCircle/RetryButtonTexture

const CRT_EFFECT = preload("res://ScreenEffect/Space/crt_effect.gdshader")
const GAME_OVER_CRT_EFFECT = preload("res://ScreenEffect/Space/game_over_crt_effect.gdshader")

@onready var crt: ColorRect = $GUI/CRT

func scored():
	score += 1
	score_label.set_text(str(score))


func lose():
	crt.material.shader = GAME_OVER_CRT_EFFECT
	var inner_tween = get_tree().create_tween()
	inner_tween.tween_property(inner_circle, "scale", Vector2(1, 1), 1)
	retry_button_texture.show()


func spawn_debree(asteroid_debree_spawn_position: Vector2, bullet_debree_spawn_position: Vector2, direction: Vector2):
	var debree : CPUParticles2D = DEBREE.instantiate()
	var bullet_debree : CPUParticles2D = BULLET_DEBREE.instantiate()
	bullet_debree.emitting = true
	bullet_debree.direction = direction
	bullet_debree.position = bullet_debree_spawn_position
	debree.emitting = true
	debree.direction = direction
	debree.position = asteroid_debree_spawn_position
	add_child(bullet_debree)
	add_child(debree)
	await debree.finished and bullet_debree.finished
	debree.queue_free()
	bullet_debree.queue_free()

func spawn_ice_debree(ice_debree_spawn_position: Vector2, direction: Vector2):
	var ice_debree : CPUParticles2D = ICE_DEBREE.instantiate()
	ice_debree.emitting = true
	ice_debree.direction = direction
	ice_debree.position = ice_debree_spawn_position
	add_child(ice_debree)
	await ice_debree.finished
	ice_debree.queue_free()


func _on_retry_button_pressed() -> void:
	print('Works?')
	get_tree().reload_current_scene()
	crt.material.shader = CRT_EFFECT
