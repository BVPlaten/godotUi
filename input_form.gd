extends Node2D

var ui_mgr : UiManager
var db_mgr :DatabaseManager

var event_datastruct = {
	"id": 					{ "ui_type" : "prim_key" , "table_name" : "id"               , "data_type" : {"primary_key" : true , "not_null": true, "auto_incremet": true } },
	"Datum Event" : 		{ "ui_type" : "date"     , "table_name" : "datum_event"      , "data_type" : "int"},
	"Ort" : 				{ "ui_type" : "text"     , "table_name" : "ort"              , "data_type" : "char(100)"},
	"Club Name" : 			{ "ui_type" : "text"     , "table_name" : "club_name"        , "data_type" : "char(100)"},
	"Turnier Name" : 		{ "ui_type" : "text"     , "table_name" : "turnier_name"     , "data_type" : "char(100)"},
	"Ausland" : 			{ "ui_type" : "bool"     , "table_name" : "ausland"          , "data_type" : "int"},
	"Land" : 				{ "ui_type" : "text"     , "table_name" : "land"             , "data_type" : "char(100)"},
	"Organisator" : 		{ "ui_type" : "text"     , "table_name" : "organisator"      , "data_type" : "char(100)"},
	"Bezahlt" : 			{ "ui_type" : "bool"     , "table_name" : "bezahlt"          , "data_type" : "int"},
	"Einschreiben Bis" : 	{ "ui_type" : "date"     , "table_name" : "einschreiben"     , "data_type" : "int"},
	"Proberunde" : 			{ "ui_type" : "bool"     , "table_name" : "proberunde"       , "data_type" : "int"},
	"Datum Proberunde" : 	{ "ui_type" : "date"     , "table_name" : "datum_proberunde" , "data_type" : "int"},
	"Cut" : 				{ "ui_type" : "bool"     , "table_name" : "cut"              , "data_type" : "int"},
	"Turniertage max" :		{ "ui_type" : "text"     , "table_name" : "turniertage"      , "data_type" : "char(100)"},
	"Hotel" : 				{ "ui_type" : "bool"     , "table_name" : "hotel"            , "data_type" : "int"},
	"Hotel Name" : 			{ "ui_type" : "text"     , "table_name" : "hotel_name"       , "data_type" : "char(100)"},
	"Hotel Ort" : 			{ "ui_type" : "text"     , "table_name" : "hotel_ort"        , "data_type" : "char(100)"},
	"Hotel Storno Bis" : 	{ "ui_type" : "text"     , "table_name" : "hotel_storno"     , "data_type" : "char(100)"},
	"Hotel Bezahlt" : 		{ "ui_type" : "bool"     , "table_name" : "hotel_bezahlt"    , "data_type" : "int"}
}

# value 	SQLite 	Godot
# int 	INTEGER 	TYPE_INT
# real 	REAL 	TYPE_REAL
# text 	TEXT 	TYPE_STRING
# char(?)** 	CHAR(?)** 	TYPE_STRING
# blob 	BLOB 	TYPE_PACKED_BYTE_ARRAY

var prim_key_conf = { "primary_key" : true , "not_null": true, "auto_incremet": true }

# 
func _ready() -> void:
	self.db_mgr = DatabaseManager.new( event_datastruct,  "event")
	self.ui_mgr = UiManager.new(event_datastruct)
	_add_controls()
	


# behandelt das drücken des buttons
func _add_controls():
	for widget in ui_mgr.widget_list:
		add_child(widget)
	#for i in range(ui_mgr.widget_list.size()):
		## var widget = ui_mgr.widget_list[i].get_ui_type()
		## print("Index:", i, "   ---   Element:", widget)
		#add_child(ui_mgr.widget_list[i])

func get_input():
	for widget in ui_mgr.widget_list:
		widget.get_input()
		print ("Widget   - " + str(widget.lable_text) + " : " + str(widget.inputResult) )

func _on_save_pressed() -> void:
	get_input()
	
# new dataset
func _on_new_pressed() -> void:
	for widget in ui_mgr.widget_list:
		widget.set_input("")


func _on_delete_pressed() -> void:
	print("delete pressed")


func _on_forward_pressed() -> void:
	print("forward pressed")


func _on_back_pressed() -> void:
	print("back pressed")
