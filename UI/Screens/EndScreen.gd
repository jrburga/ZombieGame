extends Control
class_name EndScreen


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")
	
func _on_visibility_changed():
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.set_custom_mouse_cursor(null)

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
	visible = false
	get_tree().paused = false


func _on_Quit_pressed():
	get_tree().change_scene("res://Title/TitleScene.tscn")
