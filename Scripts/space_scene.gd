extends Node


var score = 0
@onready var score_label: Label = $GUI/Control/ScoreLabel
const DEBREE = preload("res://Scenes/debree.tscn")
const BULLET_DEBREE = preload("res://Scenes/bullet_debree.tscn")

@onready var cam = $Camera2D
@onready var screen_size = get_viewport().size
@onready var top_edge = cam.global_position.y - screen_size.y * 0.5 * cam.zoom.y
@onready var left_edge = cam.global_position.x - screen_size.x * 0.5 * cam.zoom.x



func scored():
	score += 1
	score_label.set_text(str(score))


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
