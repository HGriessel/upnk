extends RigidBody2D

signal not_moving

@export var min_flip_power:int = 200
@export var max_flip_power:int = 700

@onready var sprite = $Sprite2D
@onready var area2d = $Area2D
@onready var emit = $RupeeEmiter/GpuParticles2D


var is_on_crown: bool = false

	
func _input(event):
	if event is InputEventMouseButton and event.button_index== MOUSE_BUTTON_RIGHT and not is_moving():
		apply_impulse(Vector2(randf_range(-1,1),-1)* randi_range(min_flip_power,max_flip_power))
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
#		var sprite = get_node("Sprite2D")
		if sprite != null and sprite.get_rect().has_point(sprite.to_local(event.position/3)) and not is_moving():
			
			apply_impulse(Vector2(randf_range(-1,1),-1)* randi_range(min_flip_power,max_flip_power))
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
	if is_moving() or is_on_crown:
		sprite.modulate = Color(.3,.3,.3,.9)
	elif not is_moving() and not is_on_crown:
		sprite.modulate = Color(1,1,1,1)

	if number_overlapping_bodies > 0 and not is_moving():
		emit.emitting = true
		Global.score = Global.score + 1
		apply_impulse(Vector2(90,-700))
		


func is_moving():
	if get_angular_velocity() < 0.1 and get_linear_velocity().length() < 0.1:
		return false
	return true


