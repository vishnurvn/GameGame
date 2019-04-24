extends KinematicBody2D

var motion = Vector2()
var MOVE_SPEED = 200
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const RELOAD_TIME = 0.4
var reloading = 0.0

func get_input():
	if Input.is_action_pressed("ui_left"):
		motion.x = -MOVE_SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = MOVE_SPEED
	else:
		motion.x = 0
		
	if Input.is_action_pressed("ui_up"):
		fire()
	
	return motion
	

func fire():
	if reloading <= 0.0:
		var bullet = BULLET.instance()
		bullet.global_position = global_position
		get_parent().add_child(bullet)
		reloading = RELOAD_TIME


func _physics_process(delta):
	motion = move_and_slide(get_input())


func _process(delta):
	reloading -= delta