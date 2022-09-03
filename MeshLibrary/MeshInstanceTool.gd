tool
extends MeshInstance
class_name MeshInstanceTool

export(bool) var _generate_mesh = false setget _on_generate_mesh

func _add_square(surface_tool : SurfaceTool, start_index : int):
	surface_tool.add_index(start_index)
	surface_tool.add_index(start_index + 1)
	surface_tool.add_index(start_index + 2)
	surface_tool.add_index(start_index)
	surface_tool.add_index(start_index + 2)
	surface_tool.add_index(start_index + 3)

func _on_generate_mesh(value):
	if not value:
		return
		
	mesh = null
	var surface_tool = SurfaceTool.new()
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var length_inside = 2
	var length_outside = 3
	var width = length_outside - length_inside
	var height = 3
	
	var __A = 2 * length_outside
	var __B = 2 * height + width
	
	var __a = 0
	var __b = length_outside / __A
	var __h = length_inside / __A
	var __i = (2 * width + length_inside) / __A 
	var __c = 1
	
	var __d = 0
	var __e = height / __B
	var __f = (height + width) / __B
	var __g = 1
	
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, 0, 0)) # 0
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, 0, 0)) # 1
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, 0, length_outside)) # 2
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, length_outside)) # 3
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, width)) # 4
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, 0, width)) # 5
	
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, 0)) # 6
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, 0)) # 7
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, length_outside)) # 8
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, length_outside)) # 9
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, width)) # 10
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, width)) # 11
	
	# inside face 1
	surface_tool.add_uv(Vector2(0, 0)) 
	surface_tool.add_vertex(Vector3(0, 0, width)) # 12
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, width)) # 13
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, width)) # 14
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, width)) # 15
	
	_add_square(surface_tool, 12)
	
	# inside face 2
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, width)) # 16
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, width)) # 17
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, length_outside)) # 18
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, length_outside)) # 19
	
	_add_square(surface_tool, 16)
	
	# outside face 3
	surface_tool.add_uv(Vector2(0, 0)) 
	surface_tool.add_vertex(Vector3(length_outside, 0, 0)) # 20
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, 0)) # 21
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, 0)) # 22
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, 0, 0)) # 23
	
	_add_square(surface_tool, 20)
	
	# outside face 4
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, 0, length_outside)) # 24
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, length_outside)) # 25
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, 0)) # 26
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, 0, 0)) # 27
	
	_add_square(surface_tool, 24)
	
	# side face 5
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, 0, 0)) # 28
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, 0)) # 29
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, height, width)) # 30
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(0, 0, width)) # 31
	
	_add_square(surface_tool, 28)

	# side face 6
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, 0, length_outside)) # 32
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_inside, height, length_outside)) # 33
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, height, length_outside)) # 34
	surface_tool.add_uv(Vector2(0, 0))
	surface_tool.add_vertex(Vector3(length_outside, 0, length_outside)) # 35
	
	_add_square(surface_tool, 32)
	
	# bottom
	surface_tool.add_index(0)
	surface_tool.add_index(4)
	surface_tool.add_index(1)
	
	surface_tool.add_index(0)
	surface_tool.add_index(5)
	surface_tool.add_index(4)
	
	surface_tool.add_index(1)
	surface_tool.add_index(4)
	surface_tool.add_index(2)
	
	surface_tool.add_index(4)
	surface_tool.add_index(3)
	surface_tool.add_index(2)
	
	# top
	surface_tool.add_index(6)
	surface_tool.add_index(7)
	surface_tool.add_index(10)
	
	surface_tool.add_index(6)
	surface_tool.add_index(10)
	surface_tool.add_index(11)
	
	surface_tool.add_index(7)
	surface_tool.add_index(8)
	surface_tool.add_index(10)
	
	surface_tool.add_index(10)
	surface_tool.add_index(8)
	surface_tool.add_index(9)
	
	var array_mesh = mesh as ArrayMesh
	if array_mesh:
		array_mesh.clear_surfaces()
	mesh = surface_tool.commit(array_mesh)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
