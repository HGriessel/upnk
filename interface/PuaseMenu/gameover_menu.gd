extends Control

@onready var score_lable = $Score

signal restart_btn_presed

# Called when the node enters the scene tree for the first time.
func _ready():
	score_lable.text = "Score: " + str(Global.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_lable.text = "Score: " + str(Global.score)
	pass


func _on_button_pressed():
	emit_signal("restart_btn_presed")
	pass # Replace with function body.
