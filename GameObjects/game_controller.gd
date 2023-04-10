extends Node2D

@onready var game_timeout_timer = $GameTimeOut

signal game_timed_out

# Called when the node enters the scene tree for the first time.
func _ready():
	if game_timeout_timer == null:
		print("event.button_index null")
	else:
		game_timeout_timer.wait_time = Global.game_time_out
		game_timeout_timer.start()
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Global.game_time_left = game_timeout_timer.time_left
	


func _on_game_time_out_timeout():
	emit_signal("game_timed_out")



	
