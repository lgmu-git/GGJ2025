class_name Menu
extends Control

@export var scene_start: PackedScene



func _on_start_pressed() -> void:
	if (get_tree().change_scene_to_packed(scene_start) != OK):
		get_tree().quit()
