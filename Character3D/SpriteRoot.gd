tool
extends Spatial
class_name SpriteRoot

export(bool) var reapply_material = false setget _on_reapply_material
export(Material) var material = null setget _set_material

const ignore_properties = [
	'uv1_scale',
	'uv1_offset',
	'uv2_scale',
	'uv2_offset'
]

func _on_reapply_material(value):
	for child in get_children():
		if child is MeshInstance:
			if not child.mesh:
				continue
			var mesh_material = child.mesh.surface_get_material(0)
			if not mesh_material:
				mesh_material = SpatialMaterial.new()
				child.mesh.surface_set_material(0, mesh_material)
			
			_copy_material_settings(material, mesh_material)

func _set_material(value):
	material = value
	_on_reapply_material(true)
			
func _copy_material_settings(in_material : SpatialMaterial, out_material : SpatialMaterial):
	if not in_material or not out_material:
		return
		
	for property in in_material.get_property_list():
		if property.type == TYPE_NIL:
			continue
		if property.name in ignore_properties:
			continue
		out_material.set(property.name ,in_material.get(property.name))
		
