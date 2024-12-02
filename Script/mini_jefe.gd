extends PathFollow2D

var velocidad = 50
var vida = 500 * pow(1.1, Global.nivel)
var vida_actual = vida
@onready var barra_vida = $Barra_vida

func _process(_delta):
	_actualizar_vida()
	_vida()

func _physics_process(_delta):
	progress += velocidad * _delta

func _vida():
	if vida_actual <= 0:
		queue_free()
		barra_vida.queue_free()
		Global.cash += 750
	_actualizar_vida()


func _actualizar_vida():
	barra_vida.value = int(vida_actual)
	barra_vida.max_value = vida
	barra_vida.get_child(0).text = str(int(vida_actual), " / ", int(vida))
