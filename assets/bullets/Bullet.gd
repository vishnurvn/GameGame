extends Area2D

const VELOCITY = -500

func _process(delta):
	move(delta)
	removeWhenOffScreen()
	var overlapping_areas = get_overlapping_areas()
	if len(overlapping_areas) > 0:
		if overlapping_areas[0].name == 'EnemyShip':
			self.queue_free()

func move(delta):
	global_position.y += VELOCITY*delta
	
func removeWhenOffScreen():
	if global_position.y < 0:
		queue_free()