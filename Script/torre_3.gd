extends Node2D

var shoot = true
const ROTATION_OFFSET = PI / 2
var municion = preload("res://Escenas/Municion/proyectil_missile.tscn")

@onready var timer = $Velocidad_disparo
var velocidad_disparo = 2
var enemigos_en_area = []
var nivel_torre = 1
var subir_nivel = 200
var daño = Global.daño_proyectil_missile
var valor_total = 200

func _ready():
	timer.wait_time = velocidad_disparo
	timer.one_shot = true
	timer.start()

func _process(delta):
	$VBoxContainer/Subir_nivel.text = str("Subir Nivel: $", subir_nivel)
	$VBoxContainer/Label.text = str("Nivel: ", nivel_torre)
	$VBoxContainer/HBoxContainer/Label.text = str("Daño: ", daño)
	$VBoxContainer/HBoxContainer/Label2.text = str("Rango: ", $area/area_vision.shape.radius)
	$VBoxContainer/Vender.text = str("Vender: $", valor_total*.6)
	_alerta()
	if Input.is_action_just_pressed("click_d"):
		$VBoxContainer.visible = false
	if enemigos_en_area.size() > 0 and shoot:
		var objetivo = obtener_enemigo_mas_avanzado()
		if objetivo:
			disparar(objetivo)

func _on_area_area_entered(area):
	if area.is_in_group("Enemigo") and not enemigos_en_area.has(area):
		enemigos_en_area.append(area)

func _on_area_area_exited(area):
	if area.is_in_group("Enemigo") and enemigos_en_area.has(area):
		enemigos_en_area.erase(area)

func obtener_enemigo_mas_avanzado():
	if enemigos_en_area.size() == 0:
		return null
	var mas_avanzado = enemigos_en_area[0]
	for enemigo in enemigos_en_area:
		if enemigo.global_position.x > mas_avanzado.global_position.x:
			mas_avanzado = enemigo
	return mas_avanzado

func disparar(area):
	$torreta.look_at(area.global_position)
	var b = municion.instantiate()
	b.daño = daño
	b.global_position = $torreta/Position2D.global_position
	b.global_rotation = $torreta.global_rotation
	get_tree().current_scene.call_deferred("add_child", b)
	$torreta.rotation += ROTATION_OFFSET
	shoot = false
	timer.start()

func _alerta():
	if $area/area_vision.disabled:
		$area/area_vision.disabled = false

func _on_velocidad_disparo_timeout():
	shoot = true

func _on_seguimiento_timeout():
	$area/area_vision.disabled = true


func _on_subir_nivel_pressed():
	if Global.cash >= subir_nivel:
		valor_total += subir_nivel
		nivel_torre += 1
		daño = daño * 2
		Global.cash -= subir_nivel
		$area/area_vision.shape.radius += 5
		subir_nivel = subir_nivel * 2


func _on_button_pressed():
	$VBoxContainer.visible = true


func _on_vender_pressed():
	Global.cash += valor_total * .6
	queue_free()
