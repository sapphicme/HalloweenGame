extends CharacterBody2D

class_name Player

enum {idle, walk}
var state = idle

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]
#@export var inventory: Inventory
@export var stats : Stats
var blend_position : Vector2 = Vector2.ZERO

var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position", 
	"parameters/walk/walk_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle", 
	"walk"
]

func _physics_process(delta):
	move(delta)
	handleCollision()
	animate()
	
func move(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_vector == Vector2.ZERO: 
		state = idle
		apply_friction(stats.friction * delta)
	else: 
		state = walk
		velocity = input_vector * stats.max_speed
		velocity = velocity.limit_length(stats.max_speed)
		blend_position = input_vector
		
	move_and_slide()

func apply_friction(amount) -> void: 
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else: 
		velocity = Vector2.ZERO

func animate() -> void: 
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)

func handleCollision():
	for i in get_slide_collision_count():
		var collision  = get_slide_collision(i)
		var collider = collision.get_collider()

#func _on_collection_box_area_entered(area):
	#if area.has_method("collect"):
	#	area.collect(inventory)
