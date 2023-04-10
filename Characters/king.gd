extends Node2D

const  STATE = {
  IDLE = "IDLE",
  ATTACKING = "ATTACKING",
}

@export var min_force = 700	
@export var max_force = 1000

var current_state = STATE.IDLE
var can_attack = false

@onready var animation_tree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var audio_player = $AudioStreamPlayer2D
@onready var hitbar = $HitBar 


func _ready():
	animation_state_machine.travel("idle")
	Events.connect('king_pig_in_motion_signal',_on_king_pig_in_motion_signal)


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and can_attack:
		animation_state_machine.travel("attack")
		emit_attacked()
		if is_critical_hit():
			audio_player.volume_db = 5
		else:
			audio_player.volume_db = -10
		audio_player.pitch_scale = randf_range(0.75,1.5) 
		audio_player.play()
		current_state = STATE.ATTACKING

func _process(_delta):
	match current_state:
		STATE.IDLE:
			pass
		STATE.ATTACKING:
			pass

func emit_attacked():
	if hitbar.is_in_hit_area():
		print("critical hit")
		Events.emit_signal("king_attacked",max_force,is_critical_hit())
	else:
		Events.emit_signal("king_attacked",min_force,is_critical_hit())

func is_critical_hit():
	return hitbar.is_in_hit_area()

func switch_to_idle():
	animation_state_machine.travel("idle")
	current_state = STATE.IDLE

func _on_king_pig_in_motion_signal(is_moving):
	can_attack = !is_moving

