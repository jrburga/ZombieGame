extends Node
class_name InventoryNode

export(Array) var weapons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_weapon(weapon):
	weapons.append(weapon)

func get_weapon(index):
	if index >= 0 and index < weapons.size():
		return weapons[index]
	return null
