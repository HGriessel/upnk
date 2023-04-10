extends RigidBody2D

const STATE := {
	IDLE = "IDLE",
	IN_MOTION = "IN_MOTION",
	AIR = "AIR",
	ON_HEAD = "ON_HEAD"
}

@export var crown_bounce_force: int = 100
@export var max_speed = 1000

@onready var crown_area = $Crown
@onready var rupee_emiter = $RupeeEmiter/GpuParticles2D
@onready var sprite = $idle
@onready var timer = $Timer
@onready var rupeeTimer = $RupeeTimer

var current_state = STATE.IDLE
var is_critical_hit = false
var can_collect_rupee = true

func _ready():
	Events.connect("king_attacked",_on_king_attacked)



func _process(_delta):
	print("process: can_collect_rupee " + str(can_collect_rupee))
	print("rupee timer king: time left " + str(rupeeTimer.time_left))
	print("timer: time left " + str(timer.time_left))
	current_state = get_current_state()
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)	
	if not can_collect_rupee:
		sprite.material.set_shader_parameter("grayscale",1)
	else:
		sprite.material.set_shader_parameter("grayscale",0)
	match current_state:
		STATE.IDLE:
			pass
		STATE.IN_MOTION:
			pass				
		STATE.ON_HEAD:
			apply_impulse(
				Vector2(randf_range(-1,1),-1)*crown_bounce_force
				)
			pass
	Events.emit_signal("king_pig_in_motion_signal", current_state == STATE.IN_MOTION)



func _on_king_attacked(force,critical_hit):
	if current_state != STATE.IN_MOTION:
		apply_impulse(Vector2(randf_range(-1,1),-1* force))
	if critical_hit:
		sprite.material.set_shader_parameter("strength",.5)
		physics_material_override.bounce = 50
		physics_material_override.friction = 0
		timer.start()

func is_in_motion():
	if get_angular_velocity() < 0.1 and get_linear_velocity().length() < 0.1:
		return false
	return true

func choose(array):
	array.shuffel()
	return array.front()

func get_current_state():
	
	var number_overlapping_bodies_with_crown = crown_area.get_overlapping_bodies().size()
	
	if number_overlapping_bodies_with_crown > 0:
		if can_collect_rupee:
			rupee_emiter.emitting = true
			Global.score = Global.score + 1
			can_collect_rupee = false
			rupeeTimer.start()
			print("RUpee trigger"+ "rupee overlapping" + str(number_overlapping_bodies_with_crown))
			
		return STATE.ON_HEAD
	if is_in_motion():
		return STATE.IN_MOTION
	return STATE.IDLE

func _on_timer_timeout():
	is_critical_hit = false
	sprite.material.set_shader_parameter("strength",0)
	physics_material_override.bounce = 0
	physics_material_override.friction = 1


func _on_rupee_timer_timeout():
	print("ON RUPEE TIMER TIMEOUT")
	can_collect_rupee = true



