extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	visible = false
	get_tree().paused = !get_tree().paused
	pass # Replace with function body.


func _on_new_game_pressed():
	SceneTransition.change_scene("res://Games/cup_game.tscn")



func _on_quit_pressed():
	get_tree().quit()
