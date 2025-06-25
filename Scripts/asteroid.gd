extends RigidBody2D


@onready var ice_layer: ColorRect = $Sprite2D/IceLayer
var initial_velocity


func freeze():
	linear_velocity = Vector2.ZERO
	ice_layer.show()


func unfreeze():
	linear_velocity = initial_velocity
	ice_layer.hide()
