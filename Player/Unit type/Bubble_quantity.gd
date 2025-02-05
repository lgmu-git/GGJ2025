## Description
## 
## Description
class_name Bubble_quantity
extends TextureRect

@export var text: RichTextLabel
@export var highlight: TextureRect

@export var group: StringName

var quantity: int = 0
var list: Array[Bubble]

func _init() -> void:
	add_to_group(Group.group_bubble_quantity)

func updateText(i: int) -> void:
	quantity += i
	text.text = "x" + str(quantity)

func setHighlight(a: bool) -> void:
	if (a == true):
		add_to_group(Group.group_bubble_highlight)
	else:
		if (is_in_group(Group.group_bubble_highlight)):
			remove_from_group(Group.group_bubble_highlight)
	highlight.visible = a

func bubble_destroyed(b: Bubble) -> void:
	var ind = list.find(b)
	if (ind != -1):
		list.remove_at(ind)
	quantity = list.size()
	text.text = "x" + str(quantity)

func rotateBubble(val: int):
	print("--------------------")
	get_tree().call_group(group, "rotateBubble", val)
