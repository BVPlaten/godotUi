extends RefCounted
## DatabaseManager : class for using SQLite
## https://www.youtube.com/watch?v=j-BRiTrw_F0
## 
## externds RefCount for automatic memory garbage collection 
## this is the managment class for working with sql-lite
## 
## 
## 
class_name DatabaseManager

var db_path: String = "res://data.db" 	## path to the sqlite datebase file (z.B. "user://my_database.db").
var db: SQLite 							## sqlite instance
var table_name : String					## table name
var prim_key_cfg : Dictionary 			## configuration of the primary key
var table_config : Dictionary			## table structure


## constructor of the SQLite manager class
func _init( table_cnfg: Dictionary = {}, prim_key_conf : Dictionary = {}, table_nm: String = "not_given" ):
	self.table_config = table_cnfg
	self.prim_key_cfg = prim_key_conf
	self.table_name = table_nm
	db = SQLite.new()
	db_connect()


## connect to the database-file set in db_path
func db_connect() -> bool:
	if db != null:
		printerr("DatabaseManager: already connected.")
		return true # Bereits verbunden gilt als Erfolg
	db = SQLite.new()
	var error = db.open_db()
	if error != OK:
		printerr("DatabaseManager: error when opening the database '", db_path, "'. error: ", db.get_error_message())
		db = null # Verbindungsobjekt zurücksetzen bei Fehler
		return false
	else:
		print("DatabaseManager: connected succesfully '", db_path, "'.")
		return true


## close the database connection
func db_disconnect():
	if db != null:
		db.close()
		db = null # Referenz freigeben
		print("DatabaseManager: connection to database closed.")
	else:
		print("DatabaseManager: no active connetion to close .")


## create table with the primary key defined in conmstructor parameter prim_key_conf
func db_create_table(tble_name) -> void:
	db.query_with_bindings("SELECT name FROM sqlite_master WHERE type='table' AND name=?;", [tble_name])
	if not db.query_result.is_empty():
		db.drop_table(tble_name)
	db.create_table(tble_name, change_dict_keys(table_config))
	print("db_create_table(): table created")


## get a value from the table config by its key
func get_config(key_of_interest : String):
	var result = {}
	for ui_name in table_config.keys():
		var def_dict = table_config[ui_name]
		if key_of_interest in def_dict:
			# print("Key '" + str(key_of_interest) + "' exists in the key-array '" + str(ui_name) + "'.")
			result[ui_name] = def_dict[key_of_interest]
		else:
			printerr("Key '" + str(key_of_interest) + "' does not exist in the table dictionary ")
	return result


## the function generates the column names for the table from the ui-configuration
func create_string_for_tablename(ui_name: String) -> String:
	var umlaut_mapping = { "ä": "ae","ö": "oe","ü": "ue","Ä": "Ae","Ö": "Oe","Ü": "Ue" }
	var destination_name = ui_name
	for umlaut in umlaut_mapping.keys():
		var ersetzung = umlaut_mapping[umlaut]
		destination_name = destination_name.replace(umlaut, ersetzung)
	var lowercase = destination_name.to_lower()
	var result = lowercase.replace(" ", "_")
	return result


## transform the lable strings from the ui to useable column names for the database
func change_dict_keys(source: Dictionary) -> Dictionary:
	var destination = {}
	for source_key in source.keys():
		var column_name = create_string_for_tablename(source_key)
		destination[column_name] = source[source_key]
	return destination
