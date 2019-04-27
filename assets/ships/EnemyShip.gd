extends Area2D

export(int) var LIFE
const explosion = preload("res://assets/bullets/Explosion.tscn")
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const RELOAD_TIME = 0.4
var reloading = 0.0

func _process(delta):
	fire()
	for area in get_overlapping_areas():
		print(area.name)
		if "Bullet" in area.name:
			LIFE -= 10
	if LIFE <= 0:
		create_explosion()
		queue_free()
	$HealthPoint.text = str(LIFE)
	reloading -= delta
		
func create_explosion():
	var expl = explosion.instance()
	expl.global_position = global_position
	get_parent().add_child(expl)
	
func fire():
	if reloading <= 0.0:
		var bullet = BULLET.instance()
		bullet.global_position = global_position + Vector2(0, -20).rotated(global_rotation)
		bullet.global_rotation = global_rotation
		get_parent().add_child(bullet)
		reloading = RELOAD_TIME
	