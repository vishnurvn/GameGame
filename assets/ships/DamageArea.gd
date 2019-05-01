extends Area2D

signal hit

func _on_DamageArea_body_entered(body):
	if body.name == "Bullet":
		emit_signal("hit")
