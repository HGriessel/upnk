extends Node

var score = 0 
var game_time_out = 100
var game_time_left = game_time_out
var scoreNeeded = 3

var inventory = {
	"rupees" = 0
}

var settings = {
	"sound" = {
		"volume" = 100,
		"master_volume" = 100,
	}
}

func _input(event):
	if  event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		get_tree().quit()
	if  event is InputEventKey and event.pressed and event.keycode == KEY_R:
		get_tree().reload_current_scene()

