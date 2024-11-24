extends Node2D

var enemigo1 = preload("res://Enemigo1.tscn")
var enemigos_restantes = 0
@onready var timer = $next_wave
@onready var spawn_timer = $Spawn_Enemigo
@onready var sigOleada = $timer_oleada

func _ready():
	Global.node_creation_paren = self
	iniciar_oleada()  # Inicia la primera oleada

func _process(_delta):
	if enemigos_restantes <= 0 and timer.is_stopped():
		timer.start()
	
	if not timer.is_stopped():
		var elapsed_time = int(timer.time_left)
		sigOleada.text = "Sig. Oleada: " + str(elapsed_time) + " s"

func iniciar_oleada():
	Global.nivel += 1
	enemigos_restantes = 3 * Global.nivel  
	spawn_timer.start()
	update_label()

func _on_spawn_enemigo_timeout():
	if enemigos_restantes > 0:
		spawn_enemigo()
		enemigos_restantes -= 1
	else:
		update_label()

func spawn_enemigo():
	var pos = $Path2D
	var enemy = enemigo1.instantiate()
	enemy.global_position = pos.global_position
	get_node("Path2D").add_child(enemy)

func _on_next_wave_timeout():
	iniciar_oleada()  # Comienza una nueva oleada

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
		hide_buttons()  # Esconde los botones mientras hay enemigos
	else:
		show_buttons()  # Muestra los botones cuando no hay enemigos

func _on_btn_si_pressed():
	iniciar_oleada()  # Si el botón sí es presionado, iniciar una nueva oleada

func _on_btn_no_pressed():
	hide_buttons()  # Si el botón no es presionado, esconder los botones
