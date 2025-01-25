class_name Player
extends Node2D

@export_category("Camera")
@export var cam: Camera2D

@export_category("Player")
@export var health: ProgressBar
@export var soap: Soap

@export_category("Playable Character")
@export var pj: AnimatedSprite2D
@export var mov: float
@export var mov_threshold: float

# Units
@export_category("Units")
var current_bubble: Array[int] = [0, 0, 0, 0]
var current_bubble_quantity_id: int = 0

@export var bubble_1_quantity: Bubble_quantity
@export var bubble_2_quantity: Bubble_quantity
@export var bubble_3_quantity: Bubble_quantity
@export var bubble_4_quantity: Bubble_quantity

@export var bubble_1_spawn: PackedScene
@export var bubble_2_spawn: PackedScene
@export var bubble_3_spawn: PackedScene
@export var bubble_4_spawn: PackedScene

# Timer
@export_category("Timer")
@export var casting_timer: Timer
@export var Soap_timer: Timer

# Casting
@export_category("Casting")
enum casting { up, down, left, right }
var cast: Array[casting]
const cast_bubble_1: Array[casting] = [casting.up, casting.right, casting.down, casting.left]
const cast_bubble_2: Array[casting] = [casting.up, casting.down, casting.left, casting.right]
const cast_bubble_3: Array[casting] = [casting.left, casting.down, casting.right]
const cast_bubble_4: Array[casting] = [casting.left, casting.right]
@export var castth: float = 0.99

func _ready() -> void:
	reparentCamPj()

func _process(delta: float) -> void:
	if (abs(Input.get_joy_axis(0, JOY_AXIS_LEFT_X)) > mov_threshold or 
		abs(Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)) > mov_threshold):
		pj.position.x += (Input.get_joy_axis(0, JOY_AXIS_LEFT_X) * mov)
		pj.position.y += (Input.get_joy_axis(0, JOY_AXIS_LEFT_Y) * mov)
		reparentCamPj()
		# off highlight
		get_tree().call_group(Group.group_bubble_highlight, "setHighlight", false)

func _unhandled_input(event: InputEvent) -> void:
	# Selecting a Bubble trigger a camera changes
	if (event.is_action_pressed("Bubble_Selection_up")):
		var n: Array[Bubble_quantity]
		n.assign(get_tree().get_nodes_in_group(Group.group_bubble_quantity))
		n[current_bubble_quantity_id].setHighlight(false)
		if (current_bubble_quantity_id == 0):
			current_bubble_quantity_id = n.size()-1
		else:
			current_bubble_quantity_id -= 1
		n[current_bubble_quantity_id].setHighlight(true)
		if (n[current_bubble_quantity_id].list.size() > 0):
			reparentCam(n)
	if (event.is_action_pressed("Bubble_Selection_down")):
		var n: Array[Bubble_quantity]
		n.assign(get_tree().get_nodes_in_group(Group.group_bubble_quantity))
		n[current_bubble_quantity_id].setHighlight(false)
		if (current_bubble_quantity_id == n.size()-1):
			current_bubble_quantity_id = 0
		else:
			current_bubble_quantity_id += 1
		n[current_bubble_quantity_id].setHighlight(true)
		if (n[current_bubble_quantity_id].list.size() > 0):
			reparentCam(n)
	if (event.is_action_pressed("Bubble_Selection_left")):
		var n: Array[Bubble_quantity]
		n.assign(get_tree().get_nodes_in_group(Group.group_bubble_quantity))
		if (n[current_bubble_quantity_id].quantity > 0):
			if (current_bubble[current_bubble_quantity_id] > 0):
				current_bubble[current_bubble_quantity_id] -= 1
			else:
				current_bubble[current_bubble_quantity_id] = n[current_bubble_quantity_id].quantity-1
			reparentCam(n)
			n[current_bubble_quantity_id].setHighlight(true)
	if (event.is_action_pressed("Bubble_Selection_right")):
		var n: Array[Bubble_quantity]
		n.assign(get_tree().get_nodes_in_group(Group.group_bubble_quantity))
		if (n[current_bubble_quantity_id].quantity > 0):
			if (current_bubble[current_bubble_quantity_id] < n[current_bubble_quantity_id].quantity-1):
				current_bubble[current_bubble_quantity_id] += 1
			else:
				current_bubble[current_bubble_quantity_id] = 0
			reparentCam(n)
			n[current_bubble_quantity_id].setHighlight(true)
	
	# Casting
	if (event.is_action("Cast_up") and event.get_action_strength("Cast_up") > castth):
		#print(event.get_action_strength("Cast_up"))
		addCast(casting.up)
	if (event.is_action("Cast_down") and event.get_action_strength("Cast_down") > castth):
		#print(event.get_action_strength("Cast_down"))
		addCast(casting.down)
	if (event.is_action("Cast_left") and event.get_action_strength("Cast_left") > castth):
		#print(event.get_action_strength("Cast_left"))
		addCast(casting.left)
	if (event.is_action("Cast_right") and event.get_action_strength("Cast_right") > castth):
		#print(event.get_action_strength("Cast_right"))
		addCast(casting.right)

## Reset casting when timer finishes
func _on_casting_timer_timeout() -> void:
	cast.clear()

## Update Soap value
func _on_soap_timer_timeout() -> void:
	soap.val += 5
	Soap_timer.start(5)

func addCast(c: casting) -> void:
	if (cast.has(c)):
		return
	cast.append(c)
	
	# Cast if posible
	# BUBBLE 1
	if (cast == cast_bubble_1):
		print("Casting Bubble 1")
		bubble_1_quantity.list.append( spawnBubble(bubble_1_spawn) )
		bubble_1_quantity.updateText(1)
	# BUBBLE 2
	elif (cast == cast_bubble_2):
		print("Casting Bubble 2")
		bubble_2_quantity.list.append( spawnBubble(bubble_2_spawn) )
		bubble_2_quantity.updateText(1)
	# BUBBLE 3
	elif (cast == cast_bubble_3):
		print("Casting Bubble 3")
		bubble_3_quantity.list.append( spawnBubble(bubble_3_spawn) )
		bubble_3_quantity.updateText(1)
	# BUBBLE 2
	elif (cast == cast_bubble_4):
		print("Casting Bubble 4")
		bubble_4_quantity.list.append( spawnBubble(bubble_4_spawn) )
		bubble_4_quantity.updateText(1)
	else:
		casting_timer.start(0.5)

func spawnBubble(s: PackedScene) -> Bubble:
	casting_timer.stop()
	casting_timer.timeout.emit()
	var n: Bubble = s.instantiate()
	n.position = pj.position
	add_child(n)
	
	soap.val -= 7
	return n

func reparentCam(n: Array[Bubble_quantity]) -> void:
	var b: Bubble = n[current_bubble_quantity_id].list[current_bubble[current_bubble_quantity_id]]
	cam.reparent(b, true)
	cam.position = Vector2(0, 0)
func reparentCamPj() -> void:
	cam.reparent(pj)
	cam.position = Vector2(0, 0)
