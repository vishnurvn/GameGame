extends Sprite

func _ready():
	$AnimatedSprite.play("explode")
	yield($AnimatedSprite, "animation_finished")
	queue_free()