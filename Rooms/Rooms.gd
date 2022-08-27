extends Node
class_name RoomsNode

var current_room = null
var entering_room = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_tree().get_nodes_in_group("rooms"):
		var room = child as RoomArea2D
		room.deactivate_room(true)
		room.connect("body_entered", self, "_on_body_entered", [room])
		room.connect("body_exited", self, "_on_body_exited", [room])
		
func _on_body_entered(body : PhysicsBody2D, room : Area2D):
	if body is Character2D:
		if current_room == null:
			current_room = room
			current_room.activate_room()
		else:
			entering_room = room
	
func _on_body_exited(body : PhysicsBody2D, exiting_room : Area2D):
	if body is Character2D:
		if entering_room and current_room == exiting_room:
			current_room.deactivate_room()
			current_room = entering_room
			current_room.activate_room()
	entering_room = null
