extends Node2D

@export var speed : int = 800
@export var moveDist : int = 1000

@onready var hitarea = $Hitarea
@onready var movingbar = $Movingbar


@onready var startX : int = movingbar.position.x
@onready var targetX : int = movingbar.position.x + moveDist


func _ready():
	pass

func _process (delta):
	movingbar.position.x = move_to(movingbar.position.x, targetX, speed * delta)
	if movingbar.position.x == targetX:
		if targetX == startX:
			targetX = movingbar.position.x + moveDist
		else:
			targetX = startX


func move_to (current, to,step):
	var new = current
	if new < to:
		new += step 
		if new > to:
			new = to
	else:
		new -= step 
		if new < to:
			new = to            
	return new


func is_in_hit_area():
	if hitarea.get_overlapping_areas().size() > 0:
		return true
	return false
