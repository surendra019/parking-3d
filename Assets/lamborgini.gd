extends VehicleBody3D

@onready var camera = $CameraPivot/Camera3D
@onready var camera_pivot = $CameraPivot
@onready var front = $Front
@onready var back = $Back

@onready var front_view = $FrontView
@onready var left_view = $LeftView
@onready var right_view = $RightView
@onready var back_view = $BackView

const POWER = 1000

enum VIEW {BASE, FRONT, LEFT, RIGHT, BACK}

var current_view: VIEW

var initial_transform: Transform3D


func _process(delta):
	if get_parent().game_started:
		steering = Input.get_axis("right", "left") * 10 
		engine_force = Input.get_axis("backward", "forward") * POWER
		
		camera_pivot.global_position = camera_pivot.global_position.lerp(global_position, delta * 5)
		camera_pivot.transform = camera_pivot.transform.interpolate_with(transform, delta * 5)
		
		match current_view:
			0: camera.current = true
			1: front_view.current = true
			2: left_view.current = true
			3: right_view.current = true
			4: back_view.current = true
		
	else:
		engine_force = lerp(engine_force, 0.0, delta * 20)
	
	if Input.is_action_just_pressed("toggle_view"):
		toggle_view()
	

func toggle_view():
	if current_view == 4:
		current_view = 0
	else:
		current_view += 1

