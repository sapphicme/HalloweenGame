extends Area2D

var signtext : SignText
@onready var textbox = %"Sign Popup"
@onready var textLabel = %Label

#this accesses a text file unique to the sign
#this way I can implement a bunch with different text
@export var text_file = Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.visible = false
	
func _on_body_entered(body) -> void:
	if body.get_name() == "player":
		textbox.visible = true
		textLabel.text = text_file.text
		print(text_file.text)


func _on_body_exited(body) -> void:
	if body.get_name() == "player":
		textbox.visible = false
		print("player is no longer reading the sign")
