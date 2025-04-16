extends RefCounted
## UiManager : generates the user interface from a configuration dictionary

class_name UiManager

var widget_list = []											# container for the ui-controls that are created by self
var table_config : Dictionary									# configuration data 
var text_input = preload("res://input_ui/text_input.tscn")		# input control for text
var date_input = preload("res://input_ui/date_input.tscn")		# input control for date
var check_input = preload("res://input_ui/check_input.tscn")	# input control for radiobutton


func _init( table_cnfg: Dictionary = {} ):
	self.table_config = table_cnfg
	_create_by_config()


# create the UI by the configuration dictionary
func _create_by_config():
	var idx = 0
	for data_key in self.table_config.keys():
		var conf_dict = self.table_config[data_key]
		if "ui_type" in conf_dict:
			var widget_type = conf_dict["ui_type"]
			var lable_text = data_key
			var newinpt = _create_control(widget_type, lable_text)
			if newinpt != null:
				newinpt.position = Vector2( 10, 10 + (idx * 40))
				idx += 1
				widget_list.append(newinpt)


# fabrikation eines bedienelementes
func _create_control(widget_type, widget_text):
	var widget
	match widget_type:
		"text":
			widget = text_input.instantiate()
		"date":
			widget = date_input.instantiate()
		"bool":
			widget = check_input.instantiate()
		_:
			print("Unbekannter Wert in _create_control")
			return null
	widget.lable_text = widget_text
	return widget
