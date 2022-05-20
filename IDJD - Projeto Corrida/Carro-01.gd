extends Node2D
# Scrupt de Carro Principal
var vel = 200
func _physics_process(delta):
	var direcao = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		direcao = Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		direcao = Vector2(0, 1)
	if Input.is_action_pressed("ui_right"):
		direcao = Vector2(1, 0)
	if Input.is_action_pressed("ui_left"):
		direcao = Vector2(-1, 0)
		
		
	translate(direcao * vel * delta)
