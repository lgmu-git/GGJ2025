class_name Enemy_Spawner_L1
extends Node2D

@export_category("Enemies")
@export var e1: PackedScene
@export var e2: PackedScene

@export_category("Enemy Timer")
@export var e1_timer: Timer
@export var e2_timer: Timer

var spawn_pos: Array[Node2D]

func _ready() -> void:
	e1_timer.start(5)
	e2_timer.start(10)
	
	spawn_pos.assign(get_tree().get_nodes_in_group("Spawn_l1"))


func _on_e1_timer_timeout() -> void:
	if (!limitEnemies()):
		return
	var e: Enemy = e1.instantiate()
	e.position = spawn_pos.pick_random().position
	add_child(e)
	e1_timer.start(5)


func _on_e2_timer_timeout() -> void:
	if (!limitEnemies()):
		return
	var e: Enemy = e2.instantiate()
	e.position = spawn_pos.pick_random().position
	add_child(e)
	e2_timer.start(10)

func limitEnemies() -> bool:
	var ee = get_tree().get_nodes_in_group("Enemy")
	if (ee.size() > 15):
		return false
	return true
