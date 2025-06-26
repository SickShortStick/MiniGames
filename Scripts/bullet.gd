extends RigidBody2D


var direction


func _physics_process(delta: float) -> void:
	var movement = move_and_collide(direction * delta)
	if movement and movement.get_collider() and movement.get_collider().is_in_group('Asteroids'):
		var asteroid_position = movement.get_collider().position
		movement.get_collider().call("queue_free")
		queue_free()
		get_parent().scored()
		get_parent().spawn_debree(asteroid_position, position, position.direction_to(asteroid_position))
	elif movement and movement.get_collider():
		movement.get_collider().queue_free()
		for asteroid in get_tree().get_nodes_in_group("Asteroids"):
			asteroid.freeze()
		await get_tree().create_timer(2.0).timeout
		for asteroid in get_tree().get_nodes_in_group("Asteroids"):
			asteroid.unfreeze()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
