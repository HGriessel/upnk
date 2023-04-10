extends Timer

var critical_hit_time: float = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = critical_hit_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("TIMER process:" + str(time_left))
	pass
