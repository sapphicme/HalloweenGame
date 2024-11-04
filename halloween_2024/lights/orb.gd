extends PointLight2D

@export var wander_radius: float = 100.0 # Radius for the wandering range
@export var speed: float = 20.0 # Speed of the movement

var target_position: Vector2

func _ready():
	# Set the initial random target position
	set_random_target()

func _process(delta: float):
	# Move towards the target position
	var direction = (target_position - global_position).normalized()
	global_position += direction * speed * delta

	# Check if the firefly is close to the target
	if global_position.distance_to(target_position) < 5.0:
		set_random_target()

func set_random_target():
	# Set a random target within the defined radius
	var random_offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(0, wander_radius)
	target_position = global_position + random_offset
