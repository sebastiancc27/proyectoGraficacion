extends Node2D

var enemy1 = preload("res://enemigo.tscn")

func _ready():
	Global.node_creation_paren = self

func _exit_tree():
	Global.node_creation_paren = null

func _on_enemy_spawn_timer_timeout():
	print("Generando posición del enemigo")
	var enemy_position = Vector2(randf_range(-160, 70), randf_range(-10, 10))
	print("Posición generada: ", enemy_position)
	while(enemy_position.x <1200 and enemy_position.x > -200 or enemy_position.y <400 and enemy_position.y > -190):
		enemy_position = Vector2(randf_range(-460, 670), randf_range(-510, 430))
	Global.instance_node(enemy1,enemy_position, self)
	$Enemy_Spawn_Timer.wait_time*=0.95 #PERMITIRÁ HACER QUE EL SPAWN DE ENEMIGOS SEA RAPIDO
	
	
