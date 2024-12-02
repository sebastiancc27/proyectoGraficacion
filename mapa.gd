extends Node2D

var enemigo1 = preload("res://Enemigo1.tscn")
var enemigo2 = preload("res://Enemigo2.tscn")
var jefe = preload("res://Escenas/Jefe.tscn")
var miniJefe = preload("res://Escenas/miniJefe.tscn")
var torre_1 = preload("res://Escenas/torre_1.tscn")
var enemigos_restantes = 3
var enemigos_a_generar = []
@onready var timer = $next_wave
@onready var spawn_timer = $Spawn_Enemigo
@onready var sigOleada = $Tekstuur/timer_oleada

func _ready():
	Global.node_creation_paren = self
	iniciar_oleada()

func _process(_delta):
	# Iniciar el timer solo si no hay enemigos pendientes de generar o en el mapa
	if enemigos_a_generar.size() == 0 and timer.is_stopped() and enemigos_restantes <= 0:
		timer.start()
	
	# Mostrar tiempo restante en pantalla si el timer está corriendo
	if not timer.is_stopped():
		var elapsed_time = int(timer.time_left)
		sigOleada.text = "" + str(elapsed_time) + " segundos"

func iniciar_oleada():
	Global.nivel += 1
	Global.cash += 300
	
	if Global.nivel % 15 == 0:  
		enemigos_a_generar = [jefe]
		enemigos_restantes = 1
	elif Global.nivel % 5 == 0: 
		enemigos_a_generar = generar_lista_enemigos(Global.nivel - 1)
		enemigos_a_generar.append(miniJefe)
		enemigos_restantes = enemigos_a_generar.size()
	else:  
		enemigos_a_generar = generar_lista_enemigos(Global.nivel)
		enemigos_restantes = 3 * Global.nivel

	enemigos_a_generar.shuffle()
	spawn_timer.start()
	update_label()

	# Detener el temporizador para la próxima oleada hasta que el jugador lo decida
	timer.stop()

func _on_spawn_enemigo_timeout():
	if enemigos_restantes > 0:
		spawn_enemigo()
		enemigos_restantes -= 1
	else:
		update_label()

func generar_lista_enemigos(nivel):
	var lista = []
	var total_enemigos = 3 * nivel
	var cantidad_tipo1 = int(total_enemigos * 0.75)
	var cantidad_tipo2 = total_enemigos - cantidad_tipo1
	for i in range(cantidad_tipo1):
		lista.append(enemigo1)
	for i in range(cantidad_tipo2):
		lista.append(enemigo2)
	lista.shuffle()
	return lista

func spawn_enemigo():
	if enemigos_a_generar.size() > 0:
		var pos = $Path2D
		var enemy_scene = enemigos_a_generar.pop_front()
		var enemy = enemy_scene.instantiate()
		enemy.global_position = pos.global_position
		get_node("Path2D").add_child(enemy)
	else:
		spawn_timer.stop()
		update_label()

func _on_next_wave_timeout():
	iniciar_oleada()

func hide_buttons():
	$container_next_wave/btn_no.visible = false
	$container_next_wave/btn_si.visible = false
	$container_next_wave/pasar_oleada.visible = false

func show_buttons():
	$container_next_wave/btn_no.visible = true
	$container_next_wave/btn_si.visible = true
	$container_next_wave/pasar_oleada.visible = true

func update_label():
	if enemigos_restantes > 0:
		hide_buttons()
	else:
		show_buttons()

func _on_btn_si_pressed():
	timer.start()
	timer.stop()
	iniciar_oleada()

func _on_btn_no_pressed():
	timer.stop() 
	hide_buttons()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemigo"):
		Global.vidaBase -= 1
		$Vida.text = "Vida: " + str(Global.vidaBase)
		body.queue_free()

func _on_final_area_entered(area):
	if area.is_in_group("Enemigo"):
		var barra_vida = area.get_parent().get_node("Barra_vida")
		if barra_vida:
			barra_vida.visible = false
		area.queue_free()
		_disminuir_vida()
	if Global.vidaBase <= 0:
		get_tree().change_scene_to_file("res://gameOver.tscn")
		_reiniciar_juego()

func _disminuir_vida():
	if Global.vidaBase > 0:
		Global.vidaBase -= 1
		if $Tekstuur/HBoxContainer.get_child_count() > 0:
			var ultimo_corazon = $Tekstuur/HBoxContainer.get_child($Tekstuur/HBoxContainer.get_child_count() - 1)
			ultimo_corazon.queue_free()

func _reiniciar_juego():
	Global.cash = 100
	Global.nivel = 0
