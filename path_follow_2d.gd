extends PathFollow2D

var velocidad = 100
var vida = 2 * Global.vida + Global.nivel

func _process(_delta):
	_vida()

func _physics_process(_delta):
	progress += velocidad * _delta

func _vida():
	if vida <= 0:
		queue_free()
		Global.cash += 10


func _on_area_2d_area_entered(area):
	if area.is_in_group("Proyectil"):
		vida -= Global.daño_player
	if area.is_in_group("Proyectil_cannon"):
		vida -= Global.daño_proyectil_cannon
	if area.is_in_group("Proyectil_mg"):
		vida -= Global.daño_proyectil_mg
	if area.is_in_group("Proyectil_missile"):
		vida -= Global.daño_proyectil_missile
