extends Label

class_name SignText
# Called when the node enters the scene tree for the first time.
var text_test : String = ""
@onready var textLabel = %Label

func _ready():
	textLabel.text = "this is on load"
	
