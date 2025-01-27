class_name Enemy
extends Node2D

@export var sprite: AnimatedSprite2D
@export var health: ProgressBar

@export var audio_damage: AudioStreamPlayer2D

func _ready() -> void:
	add_to_group("Enemy")
