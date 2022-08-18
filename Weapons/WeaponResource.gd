extends Resource
class_name WeaponResource


export(String) var id : String = "weapon_id"
export(String) var display_name : String = "Weapon Name"
export(PackedScene) var WeaponScene : PackedScene

export(bool) var automatic = false
export(int) var magazine_size : int = 10

export(float) var bullet_lifetime : float = 10.0
export(float) var bullet_spread : float = 0.0
export(float) var bullet_speed = 5
export(int) var bullets_spawned = 1
export(float) var seconds_per_bullet = 0

export(float) var cooldown = 0

export(float) var damage_per_bullet = 10

export(bool) var knock_back = false
export(float) var knock_back_power = 0

export(bool) var stun = false
export(float) var stun_time = 0
