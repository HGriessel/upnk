extends Node2D

@export var RANDOM_SHAKE_STRENGTH = 30.0
@export var SHAKE_DECAY_RATE = 5.0

@export var NOISE_SHAKE_SPEED = 30.0
@export var NOISE_SHAKE_STRENGTH = 60.0



@onready var camera = $Camera2D
@onready var rand = RandomNumberGenerator.new()
@onready var noise = FastNoiseLite.new()

var noise_i: float  = .0
var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = rand.randi()
	noise.frequency = 2
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shake_strength = lerp(shake_strength , 0.0, SHAKE_DECAY_RATE * delta)
	camera.offset = get_noise_offset(delta)


func apply_shake():
	shake_strength = NOISE_SHAKE_STRENGTH


func get_noise_offset(delta: float):
	noise_i += delta * NOISE_SHAKE_SPEED
	return Vector2(
		noise.get_noise_2d(1,noise_i)*shake_strength,
		noise.get_noise_2d(100,noise_i)*shake_strength
	)

func _on_king_attacked():
	apply_shake()
	pass # Replace with function body.


