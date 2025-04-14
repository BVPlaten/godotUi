# database_manager.gd
## Eine Hilfsklasse zur Verwaltung von Interaktionen mit einer SQLite-Datenbank in Godot 4.
## Diese Klasse ist von RefCounted abgeleitet, sodass sie nicht zur Szene hinzugefügt werden muss
## und automatisch vom Speicher verwaltet wird, wenn keine Referenzen mehr darauf bestehen.

## https://www.youtube.com/watch?v=j-BRiTrw_F0
extends RefCounted
class_name DatabaseManager

var db_path: String = "res://data.db" 	## Der Pfad zur SQLite-Datenbankdatei (z.B. "user://my_database.db").
var db: SQLite 							## Die SQLite-Verbindungsinstanz.
var table_name : String
var table_config : Dictionary
var table_properties : Dictionary 

## 
## parameter: 
##    table_nm: String = "not_given"   = name of the database table
##    table_cnfg: Dictionary           = dictionary contains the ui structur of data with
##                                       lable_names (key) and the type of the control 
##    table_strct : Dictionary         = the configuration for the table ( primary key stettings)
func _init( table_cnfg: Dictionary = {}, table_prprts : Dictionary = {}, table_nm: String = "not_given" ):
	self.table_config = table_cnfg
	self.table_name = table_nm
	self.table_properties = table_properties
	
	db = SQLite.new()
	db_connect()


## Baut die Verbindung zur Datenbank auf.
## Gibt 'true' bei Erfolg zurück, 'false' bei einem Fehler.
#
# 6.04.2025 bvp
func db_connect() -> bool:
	if db != null:
		printerr("DatabaseManager: Bereits verbunden.")
		return true # Bereits verbunden gilt als Erfolg
	db = SQLite.new()
	var error = db.open_db()
	if error != OK:
		printerr("DatabaseManager: Fehler beim Öffnen der Datenbank '", db_path, "'. Fehler: ", db.get_error_message())
		db = null # Verbindungsobjekt zurücksetzen bei Fehler
		return false
	else:
		print("DatabaseManager: Erfolgreich verbunden mit '", db_path, "'.")
		return true


## Schließt die Datenbankverbindung, falls sie offen ist.
func db_disconnect():
	if db != null:
		db.close()
		db = null # Referenz freigeben
		print("DatabaseManager: Datenbankverbindung geschlossen.")
	else:
		print("DatabaseManager: Keine aktive Verbindung zum Schließen vorhanden.")


## erzeugen der datenbanktabelle
func db_create_table(table_name) -> void:
	db.query_with_bindings("SELECT name FROM sqlite_master WHERE type='table' AND name=?;", [table_name])
	if not db.query_result.is_empty():
		db.drop_table(table_name)
	db.create_table(table_name, change_dict_keys(table_config))

	print("db_create_table(): Tabelle erstellt")


## Funtion gibt ein Dictionary zurück in dem die Bezeichner und die UI_Types verfügbar sind
#
# 6.04.2025 bvp
func get_config(key_of_interest : String):
	var result = {}
	for ui_name in table_config.keys():
		# Wir greifen auf das innere Dictionary zu, das dem aktuellen Schlüssel des Haupt-Dictionaries entspricht
		var def_dict = table_config[ui_name]
		if key_of_interest in def_dict:
			print("Der Schlüssel '" + str(key_of_interest) + "' existiert im Dictionary für den Hauptschlüssel '" + str(ui_name) + "'.")
			result[ui_name] = def_dict[key_of_interest]
		else:
			print("Der Schlüssel '" + str(key_of_interest) + "' existiert NICHT im Dictionary für den Hauptschlüssel '" + str(ui_name) + "'.")
	return result


## create_string_for_tablename : entfernt umlaute und großbuchstaben aus strings für einen tabellennamen
#
#
func create_string_for_tablename(eingabe_string: String) -> String:
	var umlaut_ersetzungen = { "ä": "ae","ö": "oe","ü": "ue","Ä": "Ae","Ö": "Oe","Ü": "Ue" }
	var string_mit_ersetzten_umlauten = eingabe_string
	for umlaut in umlaut_ersetzungen.keys():
		var ersetzung = umlaut_ersetzungen[umlaut]
		string_mit_ersetzten_umlauten = string_mit_ersetzten_umlauten.replace(umlaut, ersetzung)
	var kleinbuchstaben_string = string_mit_ersetzten_umlauten.to_lower()
	var string_mit_unterstrichen = kleinbuchstaben_string.replace(" ", "_")
	return string_mit_unterstrichen


# ändert das config-dict für die verwendung der tabellen-konfiguration
func change_dict_keys(eingabe_dict: Dictionary) -> Dictionary:
	var neues_dict = {}
	for schluessel in eingabe_dict.keys():
		var transformierter_schluessel = create_string_for_tablename(schluessel)
		neues_dict[transformierter_schluessel] = eingabe_dict[schluessel]
	return neues_dict
