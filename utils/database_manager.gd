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
var table_config : Dictionary			## table structure


## constructor of the SQLite manager class
func _init( table_cnfg: Dictionary = {}, table_nm: String = "not_given" ):
	self.table_config = table_cnfg
	self.table_name = table_nm
	db = SQLite.new()
	db_connect()
	change_dict_keys()


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
func db_create_table(tble_name : String, tbl_recreate : bool) -> void:
	db.query_with_bindings("SELECT name FROM sqlite_master WHERE type='table' AND name=?;", [tble_name])
	if not db.query_result.is_empty():
		if tbl_recreate:
			return
		else:
			db.drop_table(tble_name)
	#db.create_table(tble_name, change_dict_keys(table_config))
	

func change_dict_keys():
	for key in self.table_config:
		var value = self.table_config[key]["data_type"]
		if value is Dictionary:
			print("Der Wert unter dem Schlüssel '%s' ist ein Dictionary : '%s'" % [key, value])
		else:
			print("Der Wert unter dem Schlüssel '%s' ist KEIN Dictionary : '%s'" % [key, value])


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
