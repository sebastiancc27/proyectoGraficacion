extends Node2D

var enemigo1 = preload("res://Enemigo1.tscn")
var enemigo2 = preload("res://Enemigo2.tscn")
var torre_1 = preload("res://Escenas/torre_1.tscn")
var enemigos_restantes = 6
var enemigos_a_generar = []
@onready var timer = $next_wave
@onready var spawn_timer = $Spawn_Enemigo
@onready var sigOleada = $timer_oleada

func _ready():
	Global.node_creation_paren = self
	
	iniciar_oleada() 

func _process(_delta):
	if enemigos_restantes <= 0 and timer.is_stopped():
		timer.start()
	
	if not timer.is_stopped():
		var elapsed_time = int(timer.time_left)
		sigOleada.text = "Sig. Oleada: " + str(elapsed_time) + " s"

func iniciar_oleada():
	Global.nivel += 1
	Global.cash += 300
	enemigos_a_generar = generar_lista_enemigos(Global.nivel)
	enemigos_restantes = 3 * Global.nivel  
	spawn_timer.start()
	timer.start()
	update_label()

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
		$Spawn_Enemigo.stop()

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
	iniciar_oleada() 

func _on_btn_no_pressed():
	hide_buttons()  

func _on_area_2d_body_entered(body):
	print("Cuerpo detectado:", body)
	if body.is_in_group("Enemigo"):
		print("Colisión con enemigo")
		Global.vidaBase -= 1
		$Vida.text = "Vida: " + str(Global.vidaBase)
		body.queue_free()


func _on_final_area_entered(area):
	if area.is_in_group("Enemigo"):
		Global.vidaBase -= 1 
		$Vida.text = "Vida: " + str(Global.vidaBase)  
		area.queue_free()  
	if Global.vidaBase <= 0:
		get_tree().change_scene_to_file("res://menu.tscn")


func _on_button_torre_1_pressed():
	var instance = torre_1.instantiate()
	add_child(instance)
