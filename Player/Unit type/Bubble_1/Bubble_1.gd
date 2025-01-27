class_name Bubble_1
extends Bubble


func _ready() -> void:
	add_to_group(Group.group_bubble_1)

func _process(delta: float) -> void:
	position += dir * vel * delta
