extends Reference
class_name Aseprite

static func read_json(file_path : String):
	var file = File.new()
	
	var data = null
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		data = parse_json(file.get_as_text())
	return data

static func find_json(resource : Resource):
	print(resource.resource_path)
