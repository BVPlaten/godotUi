extends Control

@export var lable_text = "n.a."
@export var widget_type = "checkInput"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = lable_text

func get_ui_type():
	return widget_type + " ; " + lable_text
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
