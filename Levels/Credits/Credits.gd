class_name Credits
extends Control

@export_file() var scene_menu


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file(scene_menu)
	#if (get_tree().change_scene_to_packed(scene_menu) != OK):
		#get_tree().quit()
