extends LerpContainer

## Lets the user configure rules


@onready var nodeSpinnerCourtSize = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtSize/spinnerCourtSize
@onready var nodeSpinnerCourtsAvailable = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtsAvailable/spinnerCourtsAvailable
@onready var nodeRandomSeedButton = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/randomSeedButton
@onready var nodeSeedLineEdit = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/seedLineEdit


var ruleExport : RuleSet
signal RuleChanged


# Virtuals ####################################################
func _ready():
	nodeSeedLineEdit.text = str(hash(randf()))
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
	
func _on_spinnerCourtsAvailable_value_changed(_value:float) -> void:
	RuleChanged.emit()

func _on_spinnerCourtSize_value_changed(_value:float) -> void:
	RuleChanged.emit()

func _on_seedLineEdit_text_changed(_new_text: String) -> void:
	RuleChanged.emit()



# Helpers #####################################################
func set_export_ruleset():
	var courtSize_ : int = int(nodeSpinnerCourtSize.get_line_edit().text)
	var courtsAvailable_ : int = int(nodeSpinnerCourtsAvailable.get_line_edit().text)
	var seedButton_ : bool = nodeRandomSeedButton.is_pressed()
	var seed_ : int = hash(nodeSeedLineEdit.text)
	# Randomizes seed if randomSeedButton is toggled
	if seedButton_: seed_ = hash(randf())
	
	ruleExport = RuleSet.new(courtsAvailable_,courtSize_,seed_)
