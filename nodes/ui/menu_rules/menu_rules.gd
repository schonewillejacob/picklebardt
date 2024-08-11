extends LerpContainer

var ruleExport : RuleSet



# Virtuals ####################################################
func _ready():
	# making a dummy ruleset
	ruleExport = RuleSet.new(4,4,100)



# Signals #####################################################
# Helpers #####################################################
