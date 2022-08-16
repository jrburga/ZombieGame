extends Resource
class_name WeaponResource

export(String) var id : String = "weapon_id"
export(String) var display_name : String = "Weapon Name"
export(PackedScene) var WeaponScene : PackedScene

export(int) var magazine_size : int = 10
export(float) var reload_time_sec : float = 1.0

export(float) var hit_range : float = 10.0
export(float) var hit_spread : float = 0.0

