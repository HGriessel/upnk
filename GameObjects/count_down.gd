extends Control

@export var count_down_timer : int = 3

@onready var timer = $Timer
@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 3
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(int(timer.time_left))
	pass


func _on_timer_timeout():
	Events.emit_signal("count_down_timeout")

