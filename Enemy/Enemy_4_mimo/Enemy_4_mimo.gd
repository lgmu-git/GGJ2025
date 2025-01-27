class_name Enemy_4_mimo
extends Enemy

@onready var dir: Vector2
@export var vel: float = 20

func _ready() -> void:
	super._ready()
	

#func _process(delta: float) -> void:
	#pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	var n: Node2D = area.get_parent()
	if (n is Bubble):
		audio_damage.play()
		# delete bubble
		n.deleteBubble()
		# reduce health
		updateHealth(n.damage)
	if (n.owner is Player):
		n.owner.updateHealth(-25)

func updateHealth(val: int):
	health.value += val
	if (health.value <= 0):
		get_tree().queue_delete(self)
