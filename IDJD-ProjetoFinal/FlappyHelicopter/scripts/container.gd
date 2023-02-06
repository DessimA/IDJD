extends Container

func _ready():
	hide()
	var helicopter = utils.get_main_node().get_node("helicopter");
	if helicopter:
		helicopter.connect("state_changed", self, "_on_helicopter_state_changed")
	pass # Replace with function body.

func _on_helicopter_state_changed(helicopter):
	if helicopter.get_state() == helicopter.STATE_GROUNDED:
		get_node("anim").play("show")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
