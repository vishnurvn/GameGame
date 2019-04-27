extends KinematicBody2D

var MAX_SPEED = -200
var ACCELERATION = -10
var SPEED = 0
var velocity = Vector2(0, SPEED)
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const explosion = preload("res://assets/bullets/Explosion.tscn")
const RELOAD_TIME = 0.4
var reloading = 0.0
var rotate = 0
const ROT_SPEED = 5
var LIFE = 50

func _ready():
	pass

func get_input():
	if Input.is_action_pressed("click"):
		rotate = get_angle_to(get_global_mouse_position())
		print()
		self.rotate(rotate+deg2rad(90))
	if Input.is_action_pressed("ui_up"):
		SPEED += ACCELERATION
		velocity = Vector2(0, max(SPEED, MAX_SPEED)).rotated(rotation)
	else:
		velocity = Vector2()
	if Input.is_action_pressed("ui_accept"):
		fire()
	return velocity

func fire():
	if reloading <= 0.0:
		var bullet = BULLET.instance()
		bullet.global_position = global_position + Vector2(0, -30).rotated(rotation)
		bullet.global_rotation = global_rotation
		get_parent().add_child(bullet)
		reloading = RELOAD_TIME

func _physics_process(delta):
	velocity = move_and_slide(get_input())
	for area in $Area2D.get_overlapping_areas():
		if "Bullet" in area.name:
			LIFE -= 10
	if LIFE <= 0:
		create_explosion()
		queue_free()

func _process(delta):
	reloading -= delta

func create_explosion():
	var expl = explosion.instance()
	expl.global_position = global_position
	get_parent().add_child(expl)