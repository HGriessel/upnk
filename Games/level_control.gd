extends Control

@onready var puase_menu = $PauseMenu
@onready var game_over_menu = $GameOverMenu
# Called when the node enters the scene tree for the first time.
func _ready():
	puase_menu.visible = false
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		puase_menu.visible = true
		get_tree().paused = !get_tree().paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_game_controller_game_timed_out():
	game_over()


func game_over():
	game_over_menu.visible = true
	get_tree().paused = !get_tree().paused
	


func _on_game_over_menu_restart_btn_presed():
	Global.score = 0
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()
	pass # Replace with function body.
