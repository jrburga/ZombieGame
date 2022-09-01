tool
extends MeshLibrary
class_name MeshLibraryTool

export(bool) var add_item = false setget _on_add_item

func _on_add_item(value):
	if not value:
		return
	
	create_item(get_last_unused_item_id())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
