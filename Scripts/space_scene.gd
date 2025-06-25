extends Node


var score = 0
@onready var score_label: Label = $GUI/Control/ScoreLabel
const DEBREE = preload("res://Scenes/debree.tscn")


func scored():
	score += 1
	score_label.set_text(str(score))


func spawn_debree(spawn_position: Vector2, direction: Vector2):
	var debree : CPUParticles2D = DEBREE.instantiate()
	debree.emitting = true
	debree.direction = direction
	debree.position = spawn_position
	add_child(debree)
	await debree.finished
	debree.queue_free()
