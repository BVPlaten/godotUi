extends RefCounted  # Alternativ: extends Resource

class_name DataMgr  

# mapping ui types to database types
var ui_db_mapping = {
	"prim_key" : null, 
	"date"     : "int",
	"bool"     : "int",
	"text"     : "text" }

var table_name: String  		# NAME OF THE TABLE IN THE DATABASE
var table_cfg: Dictionary		# CONFIG FOR THE DATABASE TABLE
var ui_cfg: Dictionary			# CONFIG FOR THE UI
var data_class : DatabaseManager


## 
## parameter: 
##    table_nm: String = "not_given"   = name of the database table
##    table_cnfg: Dictionary           = dictionary contains the ui structur of data with
##                                       lable_names (key) and the type of the control 
##    table_strct : Dictionary         = the configuration for the table ( primary key stettings)
func _init(table_nm: String = "not_given", table_cnfg: Dictionary = {}, table_strct : Dictionary = {}):
	self.table_name = table_nm
	create_tabel_config(table_cnfg, table_strct)
	create_ui_config(table_cnfg)
	self.data_class = DatabaseManager.new( table_cnfg, table_strct, "event" )


## generates the configuration from the preferenc_struct
func create_tabel_config(table_cnfg: Dictionary = {}, table_strct: Dictionary ={}):
	# mapping of ui Types 
	for confKey in table_cfg.keys():
		print( confKey  + " - " + table_cfg[confKey] + " --" + ui_db_mapping[table_cfg[confKey]])

func create_ui_config(table_config : Dictionary):
	self.ui_cfg = table_config
	
	

# data_structure : beinhaltet die Konfiguration für Datenbank / UI
#                  Das value_dict wird im database manager um den spaltennamen erweitert : "table_name"
#                  
#
# 6.04.2025 bvp

#var data_structure = {
	#"id": 					{ "data_type" : "int"  , "ui_type"     : "null",  "primary_key" : true , "not_null": true, "auto_incremet": true },
	#"Datum Event" : 		{ "data_type" : "int"  , "ui_type"     : "date" },
	#"Ort" : 				{ "data_type" : "text" , "ui_type"     : "text" },
	#"Club Name" : 			{ "data_type" : "text" , "ui_type"     : "text" },
	#"Turnier Name" : 		{ "data_type" : "text" , "ui_type"     : "text" },
	#"Ausland" : 			{ "data_type" : "int"  , "ui_type"     : "bool" },
	#"Land" : 				{ "data_type" : "text" , "ui_type"     : "text" },
	#"Organisator" : 		{ "data_type" : "text" , "ui_type"     : "text" },
	#"Bezahlt" : 			{ "data_type" : "int"  , "ui_type"     : "bool" },
	#"Einschreiben Bis" : 	{ "data_type" : "int"  , "ui_type"     : "date" },
	#"Proberunde" : 			{ "data_type" : "int"  , "ui_type"     : "bool" },
	#"Datum Proberunde" : 	{ "data_type" : "int"  , "ui_type"     : "date" },
	#"Cut" : 				{ "data_type" : "int"  , "ui_type"     : "bool" },
	#"Turniertage max" :		{ "data_type" : "text" , "ui_type"     : "text" },
	#"Hotel" : 				{ "data_type" : "int"  , "ui_type"     : "bool" },
	#"Hotel Name" : 			{ "data_type" : "text" , "ui_type"     : "text" },
	#"Hotel Ort" : 			{ "data_type" : "text" , "ui_type"     : "text" },
	#"Hotel Storno Bis" : 	{ "data_type" : "text" , "ui_type"     : "text" },
	#"Hotel Bezahlt" : 		{ "data_type" : "int"  , "ui_type"     : "bool" }
#}
