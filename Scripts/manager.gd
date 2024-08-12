extends Node


var levels = []
const LEVEL_PATH = "res://Scenes/Levels/"

var current_level: int = 2


func _ready():
	dir_contents(LEVEL_PATH)

# reads the path directory.
func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				levels.append(path + file_name)
				print(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

# returns current level's scene path.
func get_current_level():
	return levels[current_level]

# set next level.
func set_next_level():
	if current_level == levels.size() - 1:
		current_level = 0
	else:
		current_level += 1
