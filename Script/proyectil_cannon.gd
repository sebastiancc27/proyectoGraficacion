extends Node2D

const RIGHT = Vector2.RIGHT
var velocidad: int = 20


func _process(_delta):
	var move = RIGHT.rotated(rotation) * velocidad
	global_position += move

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemigo"):
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
