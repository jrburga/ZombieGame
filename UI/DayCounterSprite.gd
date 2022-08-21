extends Sprite

func set_day_num(day_num):
	frame = day_num - 1
	
func get_day_num() -> int:
	return frame + 1
