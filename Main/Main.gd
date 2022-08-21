extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal game_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	find_node("Character2D").connect("finished_dying", self, "_on_character_finished_dying")
	
	find_node("DaylightNode").connect("day_started", self, "_on_daylight_day_started")

func _on_character_finished_dying():
	var end_screen = find_node("EndScreen") as EndScreen
	end_screen.visible = true
	end_screen.set_screen_death()
	
func _on_daylight_day_started():
	var daylight_node = find_node("DaylightNode") as DaylightNode
	
	if daylight_node.day_num == 12:
		emit_signal('game_complete')
		var end_screen = find_node("EndScreen") as EndScreen
		end_screen.visible = true
		end_screen.set_screen_win()
		
		get_tree().paused = true
