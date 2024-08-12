extends Node3D

@onready var cone_paths = $ConePaths
@onready var obstacles = $Obstacles

@export var car_position: Vector3
@export var parking_zone_position: Vector3
@export var car_rotation: Vector3
@export var parking_zone_rotation: Vector3
