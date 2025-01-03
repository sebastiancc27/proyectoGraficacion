extends Node2D

static var daño = 0

const RIGHT = Vector2.RIGHT
var velocidad: int = 20


func _process(_delta):
	var move = RIGHT.rotated(rotation) * velocidad
	global_position += move

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemigo"):
		var enemigo = area.get_parent()
		enemigo.vida_actual -= daño
		if enemigo.vida_actual <= 0:
			area.queue_free()
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
