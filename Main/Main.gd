extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(find_node("Character2D"))
	find_node("Character2D").connect("finished_dying", self, "_on_character_finished_dying")

func _on_character_finished_dying():
	print("on finished dying")
	var end_screen = find_node("EndScreen") as EndScreen
	end_screen.visible = true
	end_screen.set_screen_death()
