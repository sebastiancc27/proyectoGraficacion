extends Node2D

var construccion = true
var shoot = true
const ROTATION_OFFSET = PI / 2
var municion = preload("res://Escenas/Municion/proyectil_cannon.tscn")
@onready var timer = $Velocidad_disparo
var velocidad_disparo = 1
var enemigos_en_area = []
var nivel_torre = 1
var subir_nivel = 100

func _ready():
	timer.wait_time = velocidad_disparo
	timer.one_shot = true
	timer.start()
	$Construir/CollisionShape2D.disabled = true  # Desactiva la colisión inicialmente

func _process(delta):
	$VBoxContainer/Subir_nivel.text = str("Subir Nivel: $", subir_nivel)
	$VBoxContainer/Label.text = str("Nivel: ", nivel_torre)
	$VBoxContainer/HBoxContainer/Label.text = str("Daño: ", Global.daño_proyectil_cannon)
	$VBoxContainer/HBoxContainer/Label2.text = str("Rango: ", $area/area_vision.shape.radius)
	_alerta()
	if Input.is_action_just_pressed("click_d"):
		$VBoxContainer.visible = false

	if construccion:
		global_position = get_global_mouse_position()

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

func _on_button_pressed():
	if construccion:
		$Button.disabled = true
	else:
		$Butotn.disabled = false
	$VBoxContainer.visible = true

func _on_subir_nivel_pressed():
	if Global.cash >= subir_nivel:
		nivel_torre += 1
		Global.daño_proyectil_cannon = Global.daño_proyectil_cannon * 2
		Global.cash -= subir_nivel
		$area/area_vision.shape.radius += 15
		subir_nivel = subir_nivel * 2

func _on_construir_input_event(viewport, event, shape_idx):
	if construccion:
		if event.is_action_pressed("shoot"):
			global_position = event.position 
			$Construir/CollisionShape2D.disabled = true 
		elif event.is_action_released("shoot"):
			construccion = false
			$Construir/CollisionShape2D.disabled = false
