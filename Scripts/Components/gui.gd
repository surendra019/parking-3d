extends CanvasLayer


@onready var game_over_panel = $UI/GameOverPanel
@onready var start_game_panel = $UI/StartGamePanel
@onready var ui = $UI
@onready var timer = $UI/ParkingTimer/Timer
@onready var parking_timer = $UI/ParkingTimer
@onready var next_level_panel = $UI/NextLevelPanel

func _ready():
	show_main_ui(false)
	show_retry_panel(false)
	show_next_level_panel(false)
	start_timer(false)
	show_start_panel(true)
	
	#show_start_panel(false)

func _process(delta):
	parking_timer.text = str(int(timer.time_left))
	
func show_main_ui(a: bool):
	ui.visible = a
	
func show_start_panel(a: bool):
	ui.visible = a
	start_game_panel.visible = a
	get_parent().game_started = !a

func show_retry_panel(a: bool):
	ui.visible = a
	game_over_panel.visible = a
	get_parent().game_started = !a
	

func start_timer(a: bool):
	if a:
		timer.start(0)
	else:
		timer.stop()
	ui.visible = a
	parking_timer.visible = a

func show_next_level_panel(a: bool):
	ui.visible = a
	next_level_panel.visible = a
	get_parent().game_started = !a
	
func _on_retry_btn_pressed():
	#get_tree().reload_current_scene()
	get_parent().restart()
	show_retry_panel(false)


func _on_start_btn_pressed():
	show_start_panel(false)


func _on_timer_timeout():
	start_timer(false)
	show_next_level_panel(true)
	
