class_name Bubble_4
extends Bubble

@export var vel: float
@export var dir: Vector2

func _ready() -> void:
	add_to_group(Group.group_bubble_4)

func _process(delta: float) -> void:
	position += dir * vel * delta
