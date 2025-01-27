class_name Enemy_3_guard
extends Enemy

@onready var startPos: Vector2
@onready var newPos: Vector2
@onready var dir: Vector2

@export var newPos_timer: Timer
@export var vel: float = 20

func _ready() -> void:
	super._ready()
	startPos = position
	newPos_timer.start(10)

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


func _on_newPos_timer_timeout() -> void:
	newPos.x = startPos.x + randf_range(-50, 50)
	newPos.y = startPos.y + randf_range(-50, 50)
	dir = (newPos - startPos).normalized()
