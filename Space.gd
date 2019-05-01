extends Node2D


func _process(delta):
	reduce_health()

func reduce_health():
	if $PlayerShip == null:
		$CanvasLayer/GUI/HP.value = 0
	else:
		$CanvasLayer/GUI/HP.value = $PlayerShip.life
		$CanvasLayer/GUI/Shield.value = $PlayerShip.shield
