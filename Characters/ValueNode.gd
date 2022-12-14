extends Node
class_name ValueNode

export(float) var min_value : float = 0 setget set_min_value
export(float) var max_value : float = 100 setget set_max_value
export(float) var current_value : float = 100 setget set_current_value

signal current_value_changed(min_value, max_value, value_node)

func get_current_percent() -> float:
	return range_lerp(current_value, min_value, max_value, 0, 1)

func set_current_value(value):
	var prev_value = current_value
	current_value = clamp(value, min_value, max_value)
	if prev_value != current_value:
		emit_signal("current_value_changed", prev_value, current_value, self)
	
func set_min_value(value):
	min_value = value
	set_current_value(current_value)
	
func set_max_value(value):
	max_value = value
	set_current_value(current_value)
	
func update_value(delta):
	set_current_value(current_value + delta)
