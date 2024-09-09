extends Sprite2D

var velocidad = Vector2(1,0)
var rapidez = 250
var look_once=true

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once=false
	global_position+=velocidad.rotated(rotation)*rapidez*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
