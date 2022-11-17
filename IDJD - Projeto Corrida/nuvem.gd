extends Node2D
# Scrupt de Carro Principal
var vel = 200
func _physics_process(delta):
	var direcao = Vector2()
	
	direcao = Vector2(-1 , 0)	
		
	translate(direcao * vel * delta)
