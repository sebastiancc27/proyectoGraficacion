extends Node

var node_creation_paren = null
var player = null
var score = 0
var highscore = 0

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
	
#Código Angel

var nivel = 3
var vida = 20
