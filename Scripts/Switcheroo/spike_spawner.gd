extends Node


const SPIKE_SCENE = preload("res://Scenes/Switcheroo/spike.tscn")

@onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
@onready var right_spawn_point: Vector2 = $"../RightSpawnPoint".global_position
@onready var left_spawn_point: Vector2 = $"../LeftSpawnPoint".global_position
@onready var spawner_timer: Timer = $SpawnerTimer


func _on_spawner_timer_timeout() -> void:
	if not GameInfo.lost:
		var position_index = [0, 1].pick_random()
		var amount = randi_range(1, 3)
		for i in range(amount):
			var spike = SPIKE_SCENE.instantiate()
			spike.position = [left_spawn_point, right_spawn_point].get(position_index) - Vector2(0, 85) * i
			if position_index == 1:
				spike.rotation_degrees = -180
			spike.linear_velocity.y = gravity
			add_child(spike)
		return
	spawner_timer.stop()
