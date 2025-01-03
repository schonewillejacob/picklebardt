extends LerpContainer

## Lets the user configure rules


@onready var nodeSpinnerCourtSize       : SpinBox = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtSize/spinnerCourtSize
@onready var nodeSpinnerCourtsAvailable : SpinBox = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtsAvailable/spinnerCourtsAvailable
@onready var nodeRandomSeedButton       : Button = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/randomSeedButton
@onready var nodeSeedLineEdit           : LineEdit = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/seedLineEdit


var ruleExport : RuleSet
var randomSeedButtonToggled : bool
signal RuleChanged


# Virtuals ####################################################
func _ready():
	nodeSeedLineEdit.text = str(hash(randf()))
	randomSeedButtonToggled = nodeRandomSeedButton.is_pressed()
	nodeSpinnerCourtSize.get_line_edit().set_virtual_keyboard_type(4)
	nodeSpinnerCourtsAvailable.get_line_edit().set_virtual_keyboard_type(4)
	set_export_ruleset()



# Signals #####################################################
func _on_randomSeedButton_toggled(toggled_on: bool) -> void:
	if toggled_on:
		nodeSeedLineEdit.editable = false
		nodeSeedLineEdit.focus_mode = 0
	else:
		nodeSeedLineEdit.editable = true
		nodeSeedLineEdit.focus_mode = 2
	RuleChanged.emit()

func _on_spinnerCourtsAvailable_value_changed(_value:float) -> void:
	RuleChanged.emit()

func _on_spinnerCourtSize_value_changed(_value:float) -> void:
	RuleChanged.emit()

func _on_seedLineEdit_text_changed(_new_text: String) -> void:
	RuleChanged.emit()



# Helpers #####################################################
func request_to_focus_menu():
	nodeRandomSeedButton.grab_focus()

# rules -> export slot
func set_export_ruleset():
	var courtSize_       : int = int(nodeSpinnerCourtSize.get_line_edit().text)
	var courtsAvailable_ : int = int(nodeSpinnerCourtsAvailable.get_line_edit().text)
	var seed_            : int
	randomSeedButtonToggled = nodeRandomSeedButton.is_pressed()
	
	# runs if the seed has text instead of just integers
	if  str(int(nodeSeedLineEdit.text)) != nodeSeedLineEdit.text:
		seed_ = hash(nodeSeedLineEdit.text)
	else:
		seed_ = int(nodeSeedLineEdit.text)
	
	ruleExport = RuleSet.new(courtsAvailable_,courtSize_,seed_)

# export slot -> rules
func set_fields_to_current():
	nodeSpinnerCourtSize.get_line_edit().text = str(ruleExport.courtSize)
	nodeSpinnerCourtsAvailable.get_line_edit().text = str(ruleExport.courtsAvailable)
	nodeRandomSeedButton.button_pressed = randomSeedButtonToggled
	nodeSeedLineEdit.text = str(ruleExport.shuffleSeed)
