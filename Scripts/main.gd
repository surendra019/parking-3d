extends Node3D

const CONE = preload("res://Scenes/Components/cone.tscn")


@onready var gui = $GUI
@onready var parking_zone = $ParkingZone

var seperation:= 4
var game_started: bool


var car
var level_ref

func _ready():
	load_current_level()
	if get_tree().has_group("car"):
		car = get_tree().get_first_node_in_group("car")
	set_cones()
	set_dimensions()

func set_dimensions():
	car.position = level_ref.car_position
	car.rotation_degrees = level_ref.car_rotation
	
	car.initial_transform = car.global_transform
	
	parking_zone.position = level_ref.parking_zone_position
	parking_zone.rotation_degrees = level_ref.parking_zone_rotation

func load_current_level():
	level_ref = load(Manager.get_current_level()).instantiate()
	add_child(level_ref)
	
# function to spawn a cone at the given global position.
func spawn_cone(pos: Vector3):
	var cone = CONE.instantiate()
	level_ref.obstacles.add_child(cone)
	cone.global_position = pos
	
# arrange all the cones across the path 3d's curve.
func set_cones():
	for i in level_ref.cone_paths.get_children():
		var starting = 0.0
		while starting < i.curve.get_baked_length():
			var point = i.curve.sample_baked(starting)
			spawn_cone(point)
			starting += seperation
		
func game_over():
	gui.show_retry_panel(true)

func restart():
	PhysicsServer3D.body_set_state(
		car.get_rid(),
		PhysicsServer3D.BODY_STATE_TRANSFORM,
		car.initial_transform
	)
	for i in level_ref.obstacles.get_children():
		i.queue_free()
	set_cones()


func _on_next_btn_pressed():
	Manager.set_next_level()
	get_tree().reload_current_scene()
