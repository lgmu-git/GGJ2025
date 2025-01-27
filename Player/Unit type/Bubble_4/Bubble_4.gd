class_name Bubble_4
extends Bubble

var tam: float = 1

func _ready() -> void:
	add_to_group(Group.group_bubble_4)

func _process(delta: float) -> void:
	tam += vel * delta
	scale.x = tam
	scale.y = tam
	if (tam >= 2.5):
		deleteBubble()
