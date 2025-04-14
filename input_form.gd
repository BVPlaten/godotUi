extends Node2D

var ui_mgr : UiManager
var db_mgr :DatabaseManager

var event_datastruct = {
	"id": 					{ "ui_type" : "prim_key" },
	"Datum Event" : 		{ "ui_type" : "date" },
	"Ort" : 				{ "ui_type" : "text" },
	"Club Name" : 			{ "ui_type" : "text" },
	"Turnier Name" : 		{ "ui_type" : "text" },
	"Ausland" : 			{ "ui_type" : "bool" },
	"Land" : 				{ "ui_type" : "text" },
	"Organisator" : 		{ "ui_type" : "text" },
	"Bezahlt" : 			{ "ui_type" : "bool" },
	"Einschreiben Bis" : 	{ "ui_type" : "date" },
	"Proberunde" : 			{ "ui_type" : "bool" },
	"Datum Proberunde" : 	{ "ui_type" : "date" },
	"Cut" : 				{ "ui_type" : "bool" },
	"Turniertage max" :		{ "ui_type" : "text" },
	"Hotel" : 				{ "ui_type" : "bool" },
	"Hotel Name" : 			{ "ui_type" : "text" },
	"Hotel Ort" : 			{ "ui_type" : "text" },
	"Hotel Storno Bis" : 	{ "ui_type" : "text" },
	"Hotel Bezahlt" : 		{ "ui_type" : "bool" }
}
var prim_key_conf = { "primary_key" : true , "not_null": true, "auto_incremet": true }

# 
func _ready() -> void:
	self.db_mgr = DatabaseManager.new( event_datastruct, prim_key_conf, "event")
	self.ui_mgr = UiManager.new(event_datastruct)
	_add_controls()
	


# behandelt das drücken des buttons
func _add_controls():
	for i in range(ui_mgr.widget_list.size()):
		# var widget = ui_mgr.widget_list[i].get_ui_type()
		# print("Index:", i, "   ---   Element:", widget)
		add_child(ui_mgr.widget_list[i])


func _on_save_pressed() -> void:
	print("save pressed")
	
# new dataset
func _on_new_pressed() -> void:
	print("new pressed")


func _on_delete_pressed() -> void:
	print("delete pressed")


func _on_forward_pressed() -> void:
	print("forward pressed")


func _on_back_pressed() -> void:
	print("back pressed")
