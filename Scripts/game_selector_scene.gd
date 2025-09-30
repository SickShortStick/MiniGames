extends Node


const SWITCHEROO_MAIN = preload("res://Scenes/Switcheroo/switcheroo_main.tscn")
const SPACE_SCENE = preload("res://Scenes/Space/space_scene.tscn")



func _on_space_pressed() -> void:
	get_tree().change_scene_to_packed(SPACE_SCENE)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(SWITCHEROO_MAIN)
