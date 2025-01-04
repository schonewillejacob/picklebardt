extends LerpContainer

## Lets the user configure rules


@onready var nodeCourtSize = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtSize/labelCourtSize
@onready var nodeCourtsAvailable = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxCourtsAvailable/labelCourtsAvailable
@onready var nodeRandomSeedButton       : Button = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/randomSeedButton
@onready var nodeSeedLineEdit           : LineEdit = $MarginContainer/ColorRect/MarginContainer/VBoxContainer/hboxSeed/seedLineEdit


var ruleExport : RuleSet
var randomSeedButtonToggled : bool
signal RuleChanged


# Virtuals ####################################################
func _ready():
	nodeSeedLineEdit.text = str(hash(randf()))
	randomSeedButtonToggled = nodeRandomSeedButton.is_pressed()
	set_export_ruleset()



# Signals #####################################################
func _on_court_size_button_up_pressed() -> void:
	RuleChanged.emit()
	nodeCourtSize.text = "4 players per court"

func _on_court_size_button_down_pressed() -> void:
	RuleChanged.emit()
	nodeCourtSize.text = "2 players per court"

func _on_courts_available_button_down_pressed() -> void:
	RuleChanged.emit()
	var _current = int(nodeCourtsAvailable.text.get_slice(" ", 0))
	nodeCourtsAvailable.text = str(clamp(_current - 1, 1, 256)) + " courts available"

func _on_courts_available_button_up_pressed() -> void:
	RuleChanged.emit()
	var _current = int(nodeCourtsAvailable.text.get_slice(" ", 0))
	nodeCourtsAvailable.text = str(clamp(_current + 1, 1, 256)) + " courts available"
	
func _on_randomSeedButton_toggled(toggled_on: bool) -> void:
	if toggled_on:
		nodeSeedLineEdit.editable = false
		nodeSeedLineEdit.focus_mode = FocusMode.FOCUS_NONE
	else:
		nodeSeedLineEdit.editable = true
		nodeSeedLineEdit.focus_mode = FocusMode.FOCUS_ALL
	RuleChanged.emit()

func _on_seedLineEdit_text_changed(_new_text: String) -> void:
	RuleChanged.emit()



# Helpers #####################################################
func request_to_focus_menu():
	nodeRandomSeedButton.grab_focus()

# rules -> export slot
func set_export_ruleset():
	var courtSize_       : int = int(nodeCourtSize.text.get_slice(" ", 0))
	var courtsAvailable_ : int = int(nodeCourtsAvailable.text.get_slice(" ", 0))
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
	nodeCourtSize.text = str(ruleExport.courtSize) + " players per court"
	nodeCourtsAvailable.text = str(ruleExport.courtsAvailable) + " courts available"
	nodeRandomSeedButton.button_pressed = randomSeedButtonToggled
	nodeSeedLineEdit.text = str(ruleExport.shuffleSeed)
