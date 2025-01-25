## Description
## 
## Description
class_name Soap
extends ProgressBar

@export var val: int = 50:
	get:
		return val
	set(value):
		val = value
		updateValue()

func _ready() -> void:
	updateValue()

func updateValue() -> void:
	value = val
