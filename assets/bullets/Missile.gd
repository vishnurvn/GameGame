extends KinematicBody2D

const VELOCITY = -700
var velcoity = Vector2(0, VELOCITY)
var target = null
var velocity = Vector2()
var steer_force = 5

func _physics_process(delta):
	move_and_slide(seek())
	
func start(_position, _direction, _target=null):
	rotation = (_position - _direction).angle()
	position = _position
	velocity = _direction * VELOCITY
	target = _target

func seek():
	var desired = (target.position - position).normalized() * VELOCITY
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _on_CollisionArea_body_entered(body):
	queue_free()