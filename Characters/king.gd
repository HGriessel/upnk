extends Node2D

const  STATE = {
  IDLE = "IDLE",
  ATTACKING = "ATTACKING",
}

@export var min_force = 700	
@export var max_force = 700

var current_state = STATE.IDLE

signal attacked(force)

var can_attack = false
var pig_is_moving = false

@onready var animation_tree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var audio_player = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_state_machine.travel("idle")
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and can_attack:
		animation_state_machine.travel("attack")
		audio_player.pitch_scale = randf_range(0.75,1.5) # Based this on power of hit
		audio_player.play()
		current_state = STATE.ATTACKING



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_state:
		STATE.IDLE:
			pass
		STATE.ATTACKING:
			pass

func emit_attacked():
	emit_signal("attacked", randi_range(min_force,max_force))

func switch_to_idle():
	animation_state_machine.travel("idle")
	current_state = STATE.IDLE

func _on_king_pig_in_motion_signal(is_moving):
	can_attack = !is_moving

