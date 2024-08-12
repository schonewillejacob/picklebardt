extends LerpContainer

# Lets the user configure rules

var ruleExport : RuleSet



# Virtuals ####################################################
func _ready():
	var dummyRuleset_ = RuleSet.new(4,4,100)
	ruleExport = dummyRuleset_



# Signals #####################################################


# Helpers #####################################################
func set_ruleset_from_form():
	pass
