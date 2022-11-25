extends Node2D
# Scrupt de Carro Principal
var vel = 200
func _physics_process(delta):
	var direcao = Vector2()
	yield(get_tree().create_timer(1), "timeout")
	direcao = Vector2(0, -1)		
		
	translate(direcao * vel * delta)
