extends RigidBody2D

const STATE := {
	IDLE = "IDLE",
	IN_MOTION = "IN_MOTION",
	AIR = "AIR",
	ON_HEAD = "ON_HEAD"
}

@export var crown_bounce_force: int = 500
@export var max_speed = 1000

@onready var crown_area = $Crown
@onready var rupee_emiter = $RupeeEmiter/GpuParticles2D

var current_state = STATE.IDLE





func _ready():
	Events.connect("king_attacked",_on_king_attacked)
	pass 


func _process(_delta):
	current_state = get_current_state()
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)
	
	match current_state:
		STATE.IDLE:
			pass
		STATE.IN_MOTION:
			pass
		STATE.ON_HEAD:
			apply_impulse(
				Vector2(randf_range(-1,1),-1)*crown_bounce_force
				)
			rupee_emiter.emitting = true
			Global.score = Global.score + 1
			pass
	
	Events.emit_signal("king_pig_in_motion_signal", current_state == STATE.IN_MOTION)



func _on_king_attacked(force,_critical_hit):
	if current_state != STATE.IN_MOTION:
		apply_impulse(Vector2(randf_range(-1,1),-1* force))

		


func is_in_motion():
	if get_angular_velocity() < 0.1 and get_linear_velocity().length() < 0.1:
		return false
	return true

func choose(array):
	array.shuffel()
	return array.front()


func get_current_state():
	if is_in_motion():
		return STATE.IN_MOTION
	else:
		#if not in motion there is possibilty that pig could have landed on crown
		var number_overlapping_bodies_with_crown = crown_area.get_overlapping_bodies().size()
		if number_overlapping_bodies_with_crown > 0:
			return STATE.ON_HEAD
		return STATE.IDLE
