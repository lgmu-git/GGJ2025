class_name Menu
extends Control

@export_file() var scene_start
@export_file() var scene_credits




func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(scene_start)
	#if (get_tree().change_scene_to_packed(scene_start) != OK):
		#get_tree().quit()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file(scene_credits)
	#if (get_tree().change_scene_to_packed(scene_credits) != OK):
		#get_tree().quit()
