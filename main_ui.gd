extends Node2D

# Pfade zu den Szenen, die in den Tabs angezeigt werden sollen.
# WICHTIG: Die Reihenfolge MUSS der Reihenfolge der Tabs im TabBar entsprechen!
const TAB_SCENES = [ "res://about_form.tscn", "res://input_form.tscn", "res://table_form.tscn" ]

# Referenzen auf die Nodes (im Editor über den Inspektor zuweisen oder @onready verwenden)
@onready var tab_bar: TabBar = $VBoxContainer/TabBar # Passe den Pfad an deine Struktur an
@onready var content_area: Container = $VBoxContainer/ContentArea # Passe den Pfad an deine Struktur an

# Variable, um die aktuell angezeigte Szene zu speichern
var current_scene_instance = null

func _ready():
	# Stelle sicher, dass der TabBar Node gefunden wurde
	if not tab_bar:
		printerr("TabBar node not found! Check the path.")
		return
	if not content_area:
		printerr("ContentArea node not found! Check the path.")
		return

	# Verbinde das 'tab_changed' Signal des TabBar mit unserer Funktion
	# Dieses Signal wird ausgelöst, wenn ein anderer Tab ausgewählt wird
	# und übergibt den Index des neu ausgewählten Tabs.
	tab_bar.tab_changed.connect(_on_tab_bar_tab_changed)

	# Lade initial den Inhalt für den ersten Tab (Index 0)
	# Wenn du einen anderen Start-Tab möchtest, passe den Index an
	# und setze ggf. tab_bar.current_tab im _ready
	if tab_bar.tab_count > 0:
		# Stelle sicher, dass der initiale Tab auch visuell ausgewählt ist
		# (falls nicht schon im Editor gesetzt)
		# tab_bar.current_tab = 0 # Setzt den ersten Tab als aktiv
		_on_tab_bar_tab_changed(tab_bar.current_tab) # Lade den Inhalt für den aktuell ausgewählten Tab


# Diese Funktion wird aufgerufen, wenn ein Tab im TabBar gewechselt wird
func _on_tab_bar_tab_changed(tab_index: int):
	print("Tab changed to index: ", tab_index)

	# 1. Entferne die aktuell angezeigte Szene (falls vorhanden)
	if current_scene_instance:
		print("Removing previous scene: ", current_scene_instance.name)
		# Wichtig: queue_free() verwenden, um Speicher freizugeben,
		# nachdem der aktuelle Frame verarbeitet wurde.
		current_scene_instance.queue_free()
		current_scene_instance = null

	# Alternativ, wenn du sicher bist, dass immer nur EINE Szene im ContentArea ist:
	# for child in content_area.get_children():
	#     child.queue_free()

	# 2. Überprüfe, ob der Index gültig ist
	if tab_index >= 0 and tab_index < TAB_SCENES.size():
		var scene_path = TAB_SCENES[tab_index]

		# 3. Lade die neue Szene
		# Verwende load() statt preload(), wenn du nicht alle Szenen
		# direkt beim Start laden willst.
		var scene_resource = load(scene_path)

		if scene_resource:
			# 4. Instanziiere die neue Szene
			current_scene_instance = scene_resource.instantiate()

			# Stelle sicher, dass die instanziierte Szene ein Control-Node ist
			if current_scene_instance is Control:
				# Wichtig: Setze die Size Flags, damit sich die Szene ausdehnt
				current_scene_instance.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				current_scene_instance.size_flags_vertical = Control.SIZE_EXPAND_FILL

			# 5. Füge die neue Szene zum ContentArea-Container hinzu
			print("Adding new scene: ", current_scene_instance.name)
			content_area.add_child(current_scene_instance)
		else:
			printerr("Could not load scene: ", scene_path)
	else:
		printerr("Invalid tab index or scene path configuration: ", tab_index)
