extends PathFollow2D

var velocidad = 60
var vida = 1 * Global.vida

func _process(_delta):
	_vida()

func _physics_process(_delta):
	progress += velocidad * _delta

func _vida():
	if vida <= 0:
		queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Proyectil"):
		vida -= 1
