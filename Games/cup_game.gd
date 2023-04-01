extends Node2D

@onready var pigCrownColider = $pig/Crown
@onready var pigBodyColider = $pig/Body
@onready var tileMap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = pigCrownColider.test_collision(tileMap.get_used_cells_by_id(0), Vector2(), 0.0)
	var scene_tree = get_tree()
	if collision:
		scene_tree.change_scene(scene_tree.current_scene)
	pass
