extends HBoxContainer

@onready var progress_bar = $TextureProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.max_value = Global.game_time_out
	progress_bar.value = Global.game_time_left
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_bar.value = Global.game_time_left
	pass
