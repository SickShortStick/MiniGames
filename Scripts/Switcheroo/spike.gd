extends RigidBody2D
class_name Spike


var earned = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func stop():
	linear_velocity = Vector2.ZERO
