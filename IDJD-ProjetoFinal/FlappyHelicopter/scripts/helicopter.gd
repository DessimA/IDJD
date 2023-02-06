# script: helicopter
extends RigidBody2D

onready var state = FlyingState.new(self)
const STATE_FLYING		= 0
const STATE_FLAPPING		= 1
const STATE_HIT			= 2
const STATE_GROUNDED		= 3
var speed = 50
signal state_changed
var prev_state = STATE_FLAPPING

func _ready():
	add_to_group(game.GROUP_BIRDS)
	connect("body_entered", self, "_on_body_entered")
	pass
func _physics_process(delta):	
	state.update(delta)
func _input(event):
	state.input(event)
	pass
func _on_body_entered(other_body):
	if state.has_method("on_body_entered"):
		state.on_body_entered(other_body)
	pass
func set_state(new_state):
	prev_state = get_state()
	state.exit()
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
	emit_signal("state_changed", self)
	pass
func get_state():
	if state is FlyingState:
		return  STATE_FLYING
	elif state is FlappingState:
		return  STATE_FLAPPING
	elif state is HitState:
		return  STATE_HIT
	elif state is GroundedState:
		return  STATE_GROUNDED

# state management classes
class FlyingState:
	var helicopter
	var prev_gravity_scale
	func _init(helicopter):
		self.helicopter = helicopter
		helicopter.get_node("anim").play("flying")
		prev_gravity_scale = helicopter.get_gravity_scale()
		helicopter.set_linear_velocity(Vector2(helicopter.speed, helicopter.get_linear_velocity().y))
		helicopter.set_gravity_scale(0)
		pass
	func update(delta):
		pass	
	func input(event):
		pass
	func exit():
		helicopter.set_gravity_scale(prev_gravity_scale)
		helicopter.get_node("anim").stop();
		helicopter.get_node("anim_sprite").position  = Vector2(0,0)
		pass
		
class FlappingState:
	var helicopter
	func _init(helicopter):
		self.helicopter = helicopter
		helicopter.set_linear_velocity(Vector2(helicopter.speed, helicopter.get_linear_velocity().y))
		flap()
	func update(delta):
		if helicopter.rotation < deg2rad(-30):
			helicopter.rotation = deg2rad(-30)
			helicopter.set_angular_velocity(0)
		if helicopter.get_linear_velocity().y > 0:
			helicopter.set_angular_velocity(1.5)
	func input(event):
		if event.is_action_pressed("flap") or (event is InputEventScreenTouch and event.pressed):
			flap()
	func exit():
		pass
	func on_body_entered(other_body):
		if other_body.is_in_group(game.GROUP_PIPES):
			helicopter.set_state(helicopter.STATE_HIT)
		elif other_body.is_in_group(game.GROUP_GROUNDS):
			helicopter.set_state(helicopter.STATE_GROUNDED)
		pass
	func flap():
		helicopter.set_linear_velocity(Vector2(helicopter.get_linear_velocity().x, -150))
		helicopter.set_angular_velocity(-3)
		helicopter.get_node("anim").play("flap")
		helicopter.get_node("sfx_wing").play()

class HitState:
	var helicopter
	func _init(helicopter):
		self.helicopter = helicopter
		helicopter.set_linear_velocity(Vector2(0,0))
		helicopter.set_angular_velocity(2)
		var other_body = helicopter.get_colliding_bodies()[0]
		helicopter.add_collision_exception_with(other_body)
		helicopter.get_node("sfx_hit").play()
		helicopter.get_node("sfx_die").play()
		pass
	func update(delta):
		pass	
	func input(event):
		pass
	func on_body_entered(other_body):
		if other_body.is_in_group(game.GROUP_GROUNDS):
			helicopter.set_state(helicopter.STATE_GROUNDED)
		pass
	func exit():
		pass

class GroundedState:
	var helicopter
	func _init(helicopter):
		self.helicopter = helicopter
		helicopter.set_linear_velocity(Vector2(0,0))
		helicopter.set_angular_velocity(0)
		if helicopter.prev_state != helicopter.STATE_HIT:
			helicopter.get_node("sfx_hit").play()
		pass
	func update(delta):
		pass	
	func input(event):
		pass
	func exit():
		pass
