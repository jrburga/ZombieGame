extends Object
class_name Util

# https://docs.godotengine.org/en/stable/tutorials/export/feature_tags.html
const EDITOR = "editor"
const DEBUG = "debug"
const RELEASE = "release"
const STANDALONE = "standalone"

static func find_first_parent(node : Node, type):
	var parent = node.get_parent()
	while parent:
		if parent is type:
			return parent
		parent = parent.get_parent()
		
static func find_first_parent_with_method(node : Node, method_name : String):
	var parent = node.get_parent()
	while parent:
		if parent.has_method(method_name):
			return parent
		parent = parent.get_parent()

static func load_resources_in_directory(directory_name : String, in_out_array : Array):
	var path = directory_name
	var dir = Directory.new()
	
	if not dir.dir_exists(path):
		if OS.has_feature(EDITOR):
			push_warning("Failed to load resources in directory! Does not exist: " + path)
		return
		
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			var resource = load(path + "/" + file)
			if resource:
				in_out_array.append(resource)

	dir.list_dir_end()

static func find_by_id(id, items):
	for res in items:
		if "id" in res and res.id == id:
			return res
	return null

static func sort_by_id(item_a, item_b):
	if "id" in item_a and "id" in item_b:
		if item_a.id == '':
			return true
		if item_b.id == '':
			return false
		return item_a.id < item_b.id
	
	if "id" in item_a:
		return false
	if "id" in item_b:
		return true
		
static func sort_by_display_name(item_a, item_b):
	if "display_name" in item_a and "display_name" in item_b:
		if item_a.display_name == '':
			return true
		if item_b.display_name == '':
			return false
		return item_a.display_name < item_b.display_name
	
	if "display_name" in item_a:
		return false
	if "display_name" in item_b:
		return true
	
