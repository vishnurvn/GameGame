extends KinematicBody2D

var MOVE_SPEED = 200
var velocity = Vector2(0, -200)
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const RELOAD_TIME = 0.4
var reloading = 0.0

func get_input():
	var rotate = 0
	if Input.is_action_pressed("ui_right"):
		rotate = deg2rad(5)
	elif Input.is_action_pressed("ui_left"):
		rotate = deg2rad(-5)
	else:
		rotate = 0
	if Input.is_action_pressed("ui_up"):
		fire()
	
	self.rotate(rotate)
	velocity = velocity.rotated(rotate)
	return velocity

func fire():
	if reloading <= 0.0:
		var bullet = BULLET.instance()
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation
		get_parent().add_child(bullet)
		reloading = RELOAD_TIME

func _physics_process(delta):
	velocity = move_and_slide(get_input())

func _process(delta):
	reloading -= delta