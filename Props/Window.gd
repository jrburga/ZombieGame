tool
extends Node2D
class_name Window

enum State {
	CLOSED_GLASS,
	CLOSED_BROKEN,
	OPENED
}

export(State) var state = State.CLOSED_GLASS

onready var sprite_root = find_node("SpriteRoot")
onready var closed_glass = find_node("Closed_Glass")
onready var closed_broken = find_node("Closed_Broken")
onready var open = find_node("Open")

func update_window_state():
	closed_glass = find_node("Closed_Glass")
	closed_broken = find_node("Closed_Broken")
	open = find_node("Open")
	if state == State.CLOSED_GLASS:
		$WindowBody.collision_layer = 8
		closed_glass.visible = true
		closed_broken.visible = false
		open.visible = false
	elif state == State.CLOSED_BROKEN:
		$WindowBody.collision_layer = 8
		closed_glass.visible = false
		closed_broken.visible = true
		open.visible = false
	elif state == State.OPENED:
		$WindowBody.collision_layer = 128
		closed_glass.visible = false
		closed_broken.visible = false
		open.visible = true
		
func _ready():
	update_window_state()
		
func _process(delta):
	update_window_state()
