extends RigidBody2D

const VELOCITY = -700
var velcoity = Vector2(0, VELOCITY)

func _ready():
	gravity_scale = 0
	mass = 1
	weight = 9.81

func _process(delta):
	move(delta)
	removeWhenOffScreen()

func move(delta):
	var vel = velcoity.rotated(global_rotation)*delta
	global_position.x += vel.x
	global_position.y += vel.y
	
func removeWhenOffScreen():
	if global_position.y < 0:
		queue_free()

func _on_Bullet_body_entered(body):
	body
	queue_free()
