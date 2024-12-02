extends PathFollow2D

var velocidad = 100
var vida = 2000 * pow(1.1, Global.nivel)

func _process(_delta):
	_vida()

func _physics_process(_delta):
	progress += velocidad * _delta

func _vida():
	if vida <= 0:
		queue_free()
		Global.cash += 1000
