extends Node2D


func generate_asteroid(index):
	var asteroid = get_child(index).duplicate()
	asteroid.gravity_scale = 0
	asteroid.mass = 100
	asteroid.set("life", 1000)
	return asteroid