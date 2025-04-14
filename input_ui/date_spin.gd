extends Control

@onready var day_spin = $HBoxContainer/DaySpin
@onready var month_spin = $HBoxContainer/MonthSpin
@onready var year_spin = $HBoxContainer/YearSpin

@export var widget_type = "dateInput"

func _ready():
	day_spin.min_value = 1
	day_spin.max_value = 31

	month_spin.min_value = 1
	month_spin.max_value = 12

	year_spin.min_value = 2020
	year_spin.max_value = 2100

func get_selected_date():
	var date = str(day_spin.value) + "." + str(month_spin.value) + "." + str(year_spin.value)
	return date

func _on_button_pressed():
	print("Ausgewähltes Datum:", get_selected_date())
