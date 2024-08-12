extends Area3D

var car
var main
var ends_overlapped: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().has_group("car"):
		car = get_tree().get_first_node_in_group("car")
	if get_tree().get_first_node_in_group("main"):
		main = get_tree().get_first_node_in_group("main")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_area(car.front) && overlaps_area(car.back) && !ends_overlapped && main.game_started:

		main.gui.start_timer(true)
		ends_overlapped = true
	


func _on_area_exited(area):
	if area == car.front || area == car.back:
		main.gui.start_timer(false)
		ends_overlapped = false
