extends Area2D

var LIFE = 100

func _process(delta):
	if len(get_overlapping_areas()) > 0:
		LIFE -= 10
	if LIFE <= 0:
		self.queue_free()
		emit_signal("dead")