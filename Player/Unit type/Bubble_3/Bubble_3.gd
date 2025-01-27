class_name Bubble_3
extends Bubble

var target: AnimatedSprite2D
var rot: float = 0
var tran: float = 50

func _ready() -> void:
	add_to_group(Group.group_bubble_3)
	var n = get_tree().get_nodes_in_group("PJ")
	target = n[0]

func _process(delta: float) -> void:
	rot += 1 * delta
	#rotation = rot
	#position = target.position
	#translate(Vector2.UP * tran)
	#position += dir * vel * delta
	
	position.x = target.position.x + (cos(rot) * tran)
	position.y = target.position.y + (sin(rot) * tran)
