extends Control

@export var widget_type = "textInput"
var lable_text = "n.a."
var edit_text = "n.a."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextEdit.focus_mode = Control.FOCUS_ALL
	$Label.text = lable_text
	$TextEdit.text = edit_text

func get_ui_type():
	return widget_type + " ; " + lable_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("ui_focus_next") and has_focus():
		print("next focus")
		#get_parent().get_parent().get_node('line3/buy_price/buy_price').grab_focus()
		#get_tree().set_input_as_handled()
	elif event.is_action_pressed("ui_focus_next") and has_focus(): #and event.shift 
		print("prev focus")
		#get_parent().get_parent().get_node('line2/rarity/rarity').grab_focus()
		#get_tree().set_input_as_handled()
