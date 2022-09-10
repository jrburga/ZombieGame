tool
extends MeshInstance
class_name QuadMeshTool

export(bool) var reapply = false setget _on_reapply
export(Vector2) var region_size = Vector2() setget _on_region_size_set
export(Vector2) var region_offset = Vector2() setget _on_region_offset_set
export(Vector3) var center_offset = Vector3() setget _on_center_offset_set

func _on_center_offset_set(value):
	center_offset = value
	_update_mesh_size()

func _on_reapply(value):
	_update_material_uvs()

func _on_region_size_set(value):
	region_size = value
	_update_material_uvs()
	_update_mesh_size()
	
	
func _on_region_offset_set(value):
	region_offset = value
	_update_material_uvs()
	_update_mesh_size()
	
func _update_mesh_size():
	if mesh is QuadMesh:
		mesh.size = region_size / 16.0
		mesh.center_offset = center_offset / 16.0
	
func _update_material_uvs():
	var material = mesh.surface_get_material(0) as SpatialMaterial
	if not material:
		return
		
	var texture_size = material.albedo_texture.get_size()
	
	var width = float(texture_size.x)
	var height = float(texture_size.y)
	var uv_scale = Vector2(region_size.x / width, region_size.y / height)
	var uv_offset = Vector2(region_offset.x / width, region_offset.y / height)

	material.uv1_scale = Vector3(uv_scale.x, uv_scale.y, 1)
	material.uv1_offset = Vector3(uv_offset.x, uv_offset.y, 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
