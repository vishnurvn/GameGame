extends RigidBody2D

export(int) var LIFE
const explosion = preload("res://assets/bullets/Explosion.tscn")
const BULLET = preload("res://assets/bullets/Bullet.tscn")
const MISSILE = preload("res://assets/bullets/Missile.tscn")
onready var player = get_node("../PlayerShip")
var can_shoot = true
var can_shoot_missile = true
var intruder = null
var target = null
var hit_pos
var laser_color = Color(1.0, 0.329, 0.298)

func _ready():
	gravity_scale = 0
	mass = 20

func _process(delta):
	if LIFE <= 0:
		create_explosion()
		queue_free()
	$HealthPoint.text = str(LIFE)
	
func _physics_process(delta):
	if target:
		aim()
		
func _draw():
	if target:
		draw_circle((hit_pos - position).rotate(-rotation), 10, laser_color)
		draw_line(Vector2(), (hit_pos - position).rotate(-rotation), laser_color)
		
func aim():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, target.position, [self])
	if result:
		if result.collider.name == "PlayerShip":
			hit_pos = result.position
			rotation = (position - target.position).angle() - deg2rad(90)
			if can_shoot:
				fire()
			if can_shoot_missile:
#				fire_missile(target.position)
				pass

func create_explosion():
	var expl = explosion.instance()
	expl.global_position = global_position
	get_parent().add_child(expl)
	
func fire():
	var bullet = BULLET.instance()
	bullet.global_position = global_position + Vector2(0, -20).rotated(global_rotation)
	bullet.global_rotation = global_rotation
	get_parent().add_child(bullet)
	can_shoot = false
	$ShootTimer.start()

func fire_missile(pos):
	var missile = MISSILE.instance()
	var b = (pos - global_position).angle()
	missile.start(global_position, b, target)
	get_parent().add_child(missile)
	can_shoot_missile = false

func _on_EnemyShip_body_entered(body):
	if "Bullet" in body.name:
		LIFE -= 10
	if "Player" in body.name:
		LIFE -= 50

func _on_DetectionArea_body_entered(body):
	if body.name == "PlayerShip":
		target = body

func _on_DetectionArea_body_exited(body):
	if body.name == "PlayerShip":
		target = null

func _on_ShootTimer_timeout():
	can_shoot = true
