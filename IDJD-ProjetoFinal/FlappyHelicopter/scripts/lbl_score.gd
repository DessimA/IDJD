extends Label

func _ready():
	text = str(game.score_current)
	game.connect("score_current_changed", self, "_on_score_current_changed")
	var helicopter = utils.get_main_node().get_node("helicopter")
	if (helicopter):
		helicopter.connect("state_changed", self, "_on_helicopter_state_changed")
	pass

func _on_helicopter_state_changed(helicopter):
	if helicopter.get_state() == helicopter.STATE_GROUNDED: 	hide()
	if helicopter.get_state() == helicopter.STATE_HIT: hide()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_score_current_changed():
	text = str(game.score_current)
	pass
