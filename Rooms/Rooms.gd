extends Node2D
class_name RoomsNode

var current_room = null
var entering_room = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var room = child as Area2D
		
		room.deactivate_room()
		room.connect("area_entered", self, "_on_area_entered", [room])
		room.connect("area_exited", self, "_on_area_exited", [room])
		
		room.connect("body_entered", self, "_on_body_entered", [room])
		room.connect("body_exited", self, "_on_body_exited", [room])
		
func _on_area_entered(area : Area2D, room : Area2D):
	print(area.owner)
	if area.owner is Character2D:
		if current_room == null:
			current_room = room
			current_room.activate_room()
		else:
			entering_room = room
	
func _on_area_exited(area : Area2D, exiting_room : Area2D):
	if area.owner is Character2D:
		if entering_room and current_room == exiting_room:
			current_room.deactivate_room()
			current_room = entering_room
			current_room.activate_room()
	entering_room = null

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
