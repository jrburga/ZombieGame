extends Control
class_name EndScreen


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func set_screen_win():
	$WinScreen.visible = true
	$DeathScreen.visible = false
	
func set_screen_death():
	$WinScreen.visible = false
	$DeathScreen.visible = true


func _on_QuitButton_pressed():
	get_tree().change_scene("res://Title/TitleScene.tscn")


func _on_RetryButton_pressed():
	get_tree().reload_current_scene()


func _on_KeepGoing_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().change_scene("res://Title/TitleScene.tscn")
