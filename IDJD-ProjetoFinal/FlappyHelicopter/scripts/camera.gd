#script: camera

extends Camera2D

#onready var helicopter = get_node("../Helicopter")
onready var helicopter = utils.get_main_node().get_node("helicopter")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position = Vector2(helicopter.position.x, position.y)
	pass

func get_total_pos():
	return position + offset;
