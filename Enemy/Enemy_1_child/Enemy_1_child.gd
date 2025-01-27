class_name Enemy_1_child
extends Enemy

@onready var target: AnimatedSprite2D
@export var vel: float = 20

func _ready() -> void:
	super._ready()
	target = get_tree().get_nodes_in_group("PJ")[0]

func _process(delta: float) -> void:
	var xx = sign(position.x - target.position.x) * vel * delta
	var yy = sign(position.y - target.position.y) * vel * delta
	if (xx < 0):
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	position.x += xx
	position.y += yy
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	var n: Node2D = area.get_parent()
	print(n.owner)
	if (n is Bubble):
		audio_damage.play()
		# delete bubble
		n.deleteBubble()
		#await audio_damage.finished
		# reduce health
		updateHealth(n.damage)
	if (n.owner is Player):
		n.owner.updateHealth(-25)

func updateHealth(val: int):
	health.value += val
	if (health.value <= 0):
		get_tree().queue_delete(self)
