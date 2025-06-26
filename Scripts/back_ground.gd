extends AnimatedSprite2D


@export var base_size := Vector2(720, 1280)


func _ready():
	_resize()
	get_viewport().connect("size_changed", Callable(self, "_resize"))

func _resize():
	var viewport = Vector2(get_viewport().size)
	# Full-screen stretch (may distort aspect ratio)
	scale = viewport / base_size
	print(scale, viewport)
