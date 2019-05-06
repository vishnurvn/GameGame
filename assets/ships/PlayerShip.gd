extends KinematicBody2D

var MAX_SPEED = -200
var ACCELERATION = -10
var SPEED = 0
var velocity
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const explosion = preload("res://assets/bullets/Explosion.tscn")
const MISSILE = preload("res://assets/bullets/Missile.tscn")
const RELOAD_TIME = 0.4
var life = 100
var shield = 100
var can_shoot = true
var can_shoot_missile = true
var desired = Vector2(0, 0)
var speed = 250
var target = null

func _ready():
	pass

func get_input():
	if Input.is_action_pressed("click"):
		desired = get_global_mouse_position()
	if Input.is_action_pressed("ui_up"):
		velocity = (desired - position).normalized() * speed
	else:
		velocity = Vector2()
	if Input.is_action_pressed("ui_accept"):
		if can_shoot:
			fire()
	if Input.is_action_pressed("middle_click"):
		if can_shoot_missile and target:
			fire_missile()
	position.x = clamp(position.x, 0, 2024)
	position.y = clamp(position.y, 0, 1100)
	return velocity

func fire():
	var bullet = BULLET.instance()
	bullet.global_position = global_position + Vector2(0, -30).rotated(rotation)
	bullet.global_rotation = global_rotation
	get_parent().add_child(bullet)
	can_shoot = false
	$ShootTimer.start()

func fire_missile():
	var missile = MISSILE.instance()
	missile.start(position + Vector2(0, -40).rotated(rotation), target.position, target)
	get_parent().add_child(missile)
	can_shoot_missile = false
	$MissileTimer.start()

func _physics_process(delta):
	velocity = move_and_slide(get_input())
	rotation = (position - desired).angle() - deg2rad(90)
	if life <= 0:
		create_explosion()
		queue_free()

func create_explosion():
	var expl = explosion.instance()
	expl.global_position = global_position
	get_parent().add_child(expl)

func _on_DamageArea_body_entered(body):
	if body.name == "Bullet":
		if shield >= 0:
			shield -= 10
		else:
			life -= 10
	if body.name == "Missile":
		if shield >= 0:
			shield -= 10
		else:
			life -= 10
	if body.name == "EnemyShip":
		if shield >= 0:
			shield -= 50
		else:
			life -= 50

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_MissileTimer_timeout():
	can_shoot_missile = true

func _on_TargetArea_body_entered(body):
	if body.name == "EnemyShip":
		target = body

func _on_TargetArea_body_exited(body):
	if body.name == "EnemyShip":
		target = null
