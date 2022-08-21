tool
extends Node2D
class_name DalightNode

export(float, 0, 1) var day_percent = 1
export(float, 0, 1) var blood_moon_percent = 0
export(Color) var day_color = Color.white
export(Color) var night_color = Color.white
export(Color) var blood_moon_color = Color.white

# Called when the node enters the scene tree for the first time.
func _ready():
	DaylightMgr.register_daylight_node(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var adj_night_color = night_color.linear_interpolate(blood_moon_color, blood_moon_percent)
	$GlobalLight.color = adj_night_color.linear_interpolate(day_color, day_percent)
