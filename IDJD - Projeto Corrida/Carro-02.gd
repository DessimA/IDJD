extends Node2D

func _physics_process(delta):
	translate(get_position() * Vector2(0,-1) * 0.5 * delta )
