extends Control

@onready var start_button = $VBoxContainer/NewGame

# Called when the node enters the scene tree for the first time.
func _ready():
	if start_button != null:
		start_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	visible = false
	get_tree().paused = !get_tree().paused
	pass # Replace with function body.


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Games/cup_game.tscn")



func _on_quit_pressed():
	get_tree().quit()
