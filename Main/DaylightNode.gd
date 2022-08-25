tool
extends Node2D
class_name DaylightNode

enum TOD {
	DAY,
	NIGHT
}

export(int, 0, 12) var day_num : int = 0
export(TOD) var time_of_day = TOD.NIGHT
export(float) var day_length = 10.0
export(float) var night_length = 10.0
export(float, 0, 1) var day_percent = 1.0
export(float, 0, 1) var blood_moon_percent = 0.0
export(Color) var day_color = Color.white
export(Color) var night_color = Color.white
export(Color) var blood_moon_color = Color.white



signal night_started
signal day_started

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		return
		
	DaylightMgr.register_daylight_node(self)
	$NightTimer.connect("timeout", self, "_on_night_timeout")
	$DayTimer.connect("timeout", self, "_on_day_timeout")
	
	if time_of_day == TOD.NIGHT:
		$NightTimer.start(night_length)
		emit_signal("night_started")
	if time_of_day == TOD.DAY:
		$NightTimer.start(night_length)
		emit_signal("day_started")
		
	
func _on_night_timeout():
	$DayTimer.start(day_length)
	time_of_day = TOD.DAY
	emit_signal("day_started")
	$Tween.interpolate_property(self, "day_percent", 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
	
func _on_day_timeout():
	day_num += 1
	$NightTimer.start(night_length)
	time_of_day = TOD.NIGHT
	emit_signal("night_started")
	$Tween.interpolate_property(self, "day_percent", 1, 0, 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:
		if $DayTimer.wait_time > 0:
			
			day_percent = (-cos(2 * PI * $DayTimer.time_left / $DayTimer.wait_time) + 1)/2
			
		
		blood_moon_percent = day_num >= 12
	
	var adj_night_color = night_color.linear_interpolate(blood_moon_color, blood_moon_percent)
	var adj_day_color = adj_night_color.linear_interpolate(day_color, day_percent)
	$GlobalLight.color = adj_day_color
	
	
