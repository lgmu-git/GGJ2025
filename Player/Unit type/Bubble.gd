class_name Bubble
extends Node2D

@export var damage: int = -25
@export var vel: float
@export var dir: Vector2
var angle: float = 0


func rotateBubble(_val: int) -> void:
	pass
	#angle += val * (PI / 8)
	#dir = dir.from_angle(angle).normalized()
	#print(dir)


func deleteBubble() -> void:
	get_tree().call_group(Group.group_bubble_quantity, "bubble_destroyed", self)
	get_tree().queue_delete(self)
	#bubble_deleted.emit()
