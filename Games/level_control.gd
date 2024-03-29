extends Control

@onready var puase_menu = $PauseMenu
@onready var game_over_menu = $GameOverMenu


func _ready():
	get_tree().paused = true
	Events.connect("count_down_timeout",on_count_down_timeout)
	puase_menu.visible = false

func _input(event):
	if  event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		get_tree().quit()
	if  event is InputEventKey and event.pressed and event.keycode == KEY_R:
		get_tree().reload_current_scene()
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		puase_menu.visible = !puase_menu.visible 
		get_tree().paused = !get_tree().paused



func _on_game_controller_game_timed_out():
	game_over()


func game_over():
	game_over_menu.visible = true
	get_tree().paused = !get_tree().paused
	

func on_count_down_timeout():
	get_tree().paused = false
	pass

func _on_game_over_menu_restart_btn_presed():
	Global.score = 0
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()

