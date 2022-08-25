extends Resource
class_name WeaponResource


export(String) var id : String = "weapon_id"
export(String) var display_name : String = "Weapon Name"
export(PackedScene) var WeaponScene : PackedScene

export(bool) var automatic = false
export(int) var magazine_size : int = 10
export(float) var weapon_range : float = 100

export(float) var bullet_lifetime : float = 10.0
export(float) var bullet_spread : float = 0.0
export(float) var bullet_speed : float = 5
export(int) var bullets_spawned : int = 1
export(float) var seconds_per_bullet : float = 0

export(float) var cooldown : float = 0

export(float) var damage_per_bullet : float = 10

export(bool) var knock_back : bool = false
export(float) var knock_back_power : float = 0

export(bool) var stun : bool = false
export(float) var stun_time : float = 0
