extends Control

@export var count_down_timer : int = 4

@onready var timer = $Timer
@onready var label = $Label
# Called when the node enters the scene tree for the first time.

func _ready():
	timer.wait_time = count_down_timer
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.time_left < 1 :
		label.text = "SMACK'EM"
	
	elif timer.time_left < 0.5:
		visible = false
	
	else:
		label.text = str(int(timer.time_left))



func _on_timer_timeout():
	Events.emit_signal("count_down_timeout")
	visible = false

