extends RigidBody2D

const VELOCITY = -700
var velcoity = Vector2(0, VELOCITY)
var target = null
var velocity = Vector2()
var steer_force = 5

func _ready():
	gravity_scale = 0
	mass = 1
	weight = 9.81

func _process(delta):
	removeWhenOffScreen()

func move(delta):
	var vel = velcoity.rotated(global_rotation)*delta
	global_position.x += vel.x
	global_position.y += vel.y
	rotate(deg2rad(0.1))
	
func start(_position, _direction, _target=null):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * VELOCITY
	target = _target
	
func seek():
	var desired = (target.position - position).normalized() * VELOCITY
	var steer = (desired - velocity).normalized() * steer_force
	return steer
	
func removeWhenOffScreen():
	if global_position.y < 0:
		queue_free()

func _on_Missile_body_entered(body):
	queue_free()