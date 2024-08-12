extends LerpContainer

## Lets the user configure rules


@onready var nodeSpinnerCourtSize       : SpinBox = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtSize/spinnerCourtSize
@onready var nodeSpinnerCourtsAvailable : SpinBox = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtsAvailable/spinnerCourtsAvailable
@onready var nodeRandomSeedButton       : Button = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/randomSeedButton
@onready var nodeSeedLineEdit           : LineEdit = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/seedLineEdit


var ruleExport : RuleSet
var buttonRandomSeedPressed : bool
signal RuleChanged


# Virtuals ####################################################
func _ready():
	nodeSeedLineEdit.text = str(hash(randf()))
	buttonRandomSeedPressed = nodeRandomSeedButton.is_pressed()
	set_export_ruleset()



# Signals #####################################################
func _on_randomSeedButton_toggled(toggled_on: bool) -> void:
	if toggled_on:
		nodeSeedLineEdit.editable = false
		nodeSeedLineEdit.focus_mode = 0
		nodeSeedLineEdit.text = str(hash(randf()))
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

# rules -> export slot
func set_export_ruleset():
	var courtSize_ : int = int(nodeSpinnerCourtSize.get_line_edit().text)
	var courtsAvailable_ : int = int(nodeSpinnerCourtsAvailable.get_line_edit().text)
	var seedButton_ : bool = nodeRandomSeedButton.is_pressed()
	var seed_ : int
	
	# this basically checks if the seed is all numbers
	if  str(int(nodeSeedLineEdit.text)) == nodeSeedLineEdit.text:
		pass
	
	
	# Randomizes seed if randomSeedButton is toggled
	if seedButton_: seed_ = hash(randf())
	else: pass
	
	ruleExport = RuleSet.new(courtsAvailable_,courtSize_,seed_)

# export slot -> rules
func set_fields_to_current():
	nodeSpinnerCourtSize.get_line_edit().text = str(ruleExport.courtSize)
	nodeSpinnerCourtsAvailable.get_line_edit().text = str(ruleExport.courtsAvailable)
	nodeSeedLineEdit.text = str(ruleExport.shuffleSeed)
	pass
