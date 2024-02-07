extends Camera2D

var decay := 0.8
var max_offset := Vector2(20,10)
var max_roll := 0.1
@export var noise : FastNoiseLite

var noise_y = 0 

var trauma := 0.0 
var trauma_pwr := 3 

func _ready():
	Game.camera = self
	reset_smoothing()
	randomize()
	noise.seed = randi()

# https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html
# https://gist.github.com/Alkaliii/3d6d920ec3302c0ce26b5ab89b417a4a
# thank you bois <3
func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

	elif offset.x != 0 or offset.y != 0 or rotation != 0:
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)
		lerp(rotation,0.0,1)

func shake(): 
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	rotation = max_roll * amt * noise.get_noise_2d(noise.seed,noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2,noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3,noise_y)
