class_name Enemy_2_pet
extends Enemy

@onready var target: AnimatedSprite2D
@onready var dir: Vector2
@export var vel: float = 20

func _ready() -> void:
	super._ready()
	target = get_tree().get_nodes_in_group("PJ")[0]
	dir = (target.position - position).normalized()
	

func _process(delta: float) -> void:
	position += dir * vel * delta
	if (dir.x < 0):
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

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
