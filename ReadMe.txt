Plan:
	
	text.input.tscn ermöglicht die Eingabe von 
	date_input.tsn für dei EIngabe von einem Datum
	check_input wird eine binäre CheckBox
	


--------------------------------------------------------------------- ai prompt start 

Sei mein gdscript Mentor für godot 4.4

Deine Quellcodebeispiele und deine antworten sollte sich immer auf die aktuelle Version vDn gdscript beziehen. bitte achte darauf mir keine alten Lösungen zu präsentieren die in der aktuelle Fassung von godot nicht mehr nutzbar sind.
Bitte analysiere deine antworten schrittweise und achte dabei darauf ob sich das Problem nicht eleganter lösen lässt als auf den ersten blick. 
Und bitte statte deinen Code immer mit guten Kommentaren aus. und nutze die deutsche Sprache.


		#- "int" (SQLite: INTEGER, GODOT: TYPE_INT)
		#- "real" (SQLite: REAL, GODOT: TYPE_REAL)
		#- "text" (SQLite: TEXT, GODOT: TYPE_STRING)
		#- "char(?)"** (SQLite: CHAR(?)**, GODOT: TYPE_STRING)
		#- "blob" (SQLite: BLOB, GODOT: TYPE_PACKED_BYTE_ARRAY)
		#  
		#  func _ready():
		#  	var table_name: String = "players"
		#  	var table_dict: Dictionary = {
		#  		"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
		#  		"name": {"data_type":"text", "not_null": true},
		#  		"portrait": {"data_type":"blob", "not_null": true}
		#  	}
		#   "text":
		#   	widget = text_input.instantiate()
		#   "date":
		#   	widget = date_input.instantiate()
		#   "bool":
		#   	widget = check_input.instantiate()


Ideen zum Datenbankzugriff: 
	Die gesonderte Klasse database_manager macht alle Vorgänge bzugl der Datenbank. 
	Die Struktur und die speztialarbeiten übernehmen Klassen wie event_date. Event ist der 
	Tabellenname der verwendet wird und die Datenstruktur befindet sich auch in der Klasse.
	
	
	
	
