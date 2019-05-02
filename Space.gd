extends Node2D



func _ready():
	var asteroid_factory = preload("res://assets/space_stuff/AsteroidScene.tscn").instance()
	for i in range(10):
		var asteroid = asteroid_factory.generate_asteroid(randi() % 3)
		var x = rand_range(500, 1500)
		var y = rand_range(250, 1200)
		asteroid.rotation = randi() / 3
		asteroid.position = Vector2(x, y)
		add_child(asteroid)

func _process(delta):
	reduce_health()

func reduce_health():
	if $PlayerShip == null:
		$CanvasLayer/GUI/HP.value = 0
	else:
		$CanvasLayer/GUI/HP.value = $PlayerShip.life
		$CanvasLayer/GUI/Shield.value = $PlayerShip.shield
