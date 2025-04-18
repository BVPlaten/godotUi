extends Control

@onready var day_box = $HBoxContainer/DaySpin
@onready var month_box = $HBoxContainer/MonthSpin
@onready var year_box = $HBoxContainer/YearSpin
@export var inputResult : String

func _ready():
	day_box.step = 1
	day_box.min_value = 1
	day_box.max_value = 31
	day_box.value = 27
	
	month_box.step = 1
	month_box.min_value = 1
	month_box.max_value = 12
	day_box.value = 6
	
	year_box.step = 1
	year_box.min_value = 1900
	year_box.max_value = 2500
	year_box.value = 1970  # aktuelles Jahr als Startwert
	
	# Monat oder Jahr ändern → Tag validieren
	month_box.value_changed.connect(_update_day_range)
	year_box.value_changed.connect(_update_day_range)
	
	await get_tree().process_frame
	get_input()
	print("Direkter Test von get_input():", self.inputResult)


func _update_day_range(_new_value: float) -> void:
	var year := int(year_box.value)
	var month := int(month_box.value)
	var max_day := _days_in_month(month, year)
	day_box.max_value = max_day
	if day_box.value > max_day:
		day_box.value = max_day

func _days_in_month(month: int, year: int) -> int:
	match month:
		1, 3, 5, 7, 8, 10, 12:
			return 31
		4, 6, 9, 11:
			return 30
		2:
			return 29 if _is_leap_year(year) else 28
		#else:
			#return 31  # Fallback (sollte nie passieren)
	return 0

func _is_leap_year(year: int) -> bool:
	return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)


## read the users input
func get_input():
	self.inputResult = "%04d-%02d-%02d" % [int(year_box.value), int(month_box.value), int(day_box.value)]


func set_input(newDate : String):
	day_box.value = 27
	month_box.value = 7
	year_box.value = 1970
