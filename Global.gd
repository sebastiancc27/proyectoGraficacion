extends Node

var node_creation_paren = null
var player = null
var score = 0
var highscore = 0
var cash = 100000
var vidaBase = 10
var daño_proyectil_cannon = 10
var daño_proyectil_mg = 1
var daño_proyectil_missile = 40
var daño_player = 1
var nivel = 0
var vida = 100

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func save():
	var save_dic = {
		"highscore": highscore		
	}
	return save_dic
	

var save_dictionary = save()

func save_game():
	var save_game  = FileAccess.open("./savegame.txt",FileAccess.WRITE)
	save_game.store_line(JSON.stringify(highscore))
	save_game.close()
	
