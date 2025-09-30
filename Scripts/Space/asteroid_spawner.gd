extends Node


@export var asteroid_speed = 100
@onready var player: Area2D = $"../Player"
const ASTEROID = preload("res://Scenes/Space/asteroid.tscn")
@onready var spawn_line: PathFollow2D = $"../Path2D/SpawnLine"
@onready var path_2d: Path2D = $"../Path2D"


func _on_spawner_timer_timeout() -> void:
	var asteroid : RigidBody2D = ASTEROID.instantiate()
	spawn_line.progress_ratio = randf()
	asteroid.position = spawn_line.position
	asteroid.angular_velocity = randf_range(0.0, 6.0)
	var direction_to_player = asteroid.position.direction_to(player.position)
	asteroid.linear_velocity = asteroid_speed * direction_to_player
	asteroid.initial_velocity = asteroid_speed * direction_to_player
	add_sibling(asteroid)
