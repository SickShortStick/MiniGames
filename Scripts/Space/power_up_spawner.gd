extends Node


const ICE = preload("res://Scenes/ice.tscn")
@export var ice_speed = 100
@onready var player_position = $"../Player".position
@onready var spawn_line: PathFollow2D = $"../Path2D/SpawnLine"
@onready var path_2d: Path2D = $"../Path2D"


func _on_power_up_timer_timeout() -> void:
	var ice = ICE.instantiate()
	spawn_line.progress_ratio = randf()
	ice.position = spawn_line.global_position
	ice.angular_velocity = randf_range(0.0, 10.0)
	var direction_to_player = ice.position.direction_to(player_position)
	ice.linear_velocity = ice_speed * direction_to_player
	add_sibling(ice)
