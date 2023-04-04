extends RigidBody2D

signal not_moving
signal moving

@export var min_flip_power:int = 200
@export var max_flip_power:int = 700

@onready var sprite = $air
@onready var area2d = $Area2D
@onready var emit = $RupeeEmiter/GpuParticles2D


@onready var animation_tree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")

var is_on_crown: bool = false

	
#func _input(event):
	#print("get_angular_velocity" + str(get_angular_velocity()))
	#print("L" + str(get_linear_velocity()))
	#print("Is not moving" + str(is_not_moving()))
	#print(rotation_degrees)
	#print(abs(round(rotation_degrees)))
	#print(is_moving())
	#print(area2d.get_overlapping_bodies())
	#print(area2d.get_overlapping_bodies().size() )

func _physics_process(_delta):
	var number_overlapping_bodies = area2d.get_overlapping_bodies().size()
	if not is_moving():
		animation_state_machine.travel("idle")
		emit_signal("not_moving")
	else:
		animation_state_machine.travel("air") 
		emit_signal("moving")
	
	if is_moving() or is_on_crown:
		sprite.modulate = Color(.3,.3,.3,.9)
		
	elif not is_moving() and not is_on_crown:
		sprite.modulate = Color(1,1,1,1)

	if number_overlapping_bodies > 0 and not is_moving():
		landed_on_crown()
	
	if rotation_degrees != 0 and not is_moving():
		if randi_range(1,1000) > 999:
			print(rotation_degrees)
			apply_impulse(Vector2(randf_range(-1,1),-1)* randi_range(40,100))
		


func is_moving():
	if get_angular_velocity() < 0.1 and get_linear_velocity().length() < 0.1:
		return false
	return true


func apply_attack():
	apply_impulse(Vector2(randf_range(-1,1),-1)* randi_range(min_flip_power,max_flip_power))

func landed_on_crown():
	emit.emitting = true
	Global.score = Global.score + 1
	apply_impulse(Vector2(90,-700))

func _on_not_moving():
	pass # Replace with function body.


func _on_king_attacked():
	apply_attack()
	pass # Replace with function body.
