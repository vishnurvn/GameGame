extends Area2D

const VELOCITY = -500
var velcoity = Vector2(0, -500)

func _process(delta):
	move(delta)
	removeWhenOffScreen()
	var overlapping_areas = get_overlapping_areas()
	
	if len(overlapping_areas) > 0:
		queue_free()

func move(delta):
	var vel = velcoity.rotated(global_rotation)*delta
	global_position.x += vel.x
	global_position.y += vel.y
	
func removeWhenOffScreen():
	if global_position.y < 0:
		queue_free()