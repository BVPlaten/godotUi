extends Control

@export var lable_text = "n.a."
@export var widget_type = "checkInput"
@export var inputResult : String

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = lable_text

## information about the widget
func get_ui_type():
	return widget_type + " ; " + lable_text
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## read the users input
func get_input():
	$DateSpin.get_input()
	self.inputResult = $DateSpin.inputResult

func set_input(newDate: String):
	$DateSpin.set_input(newDate)
	self.inputResult = newDate
