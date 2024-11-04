extends Node2D


var enemigo1 = preload("res://Enemigo1.tscn")
var enemigos = 5 * Global.nivel

func _physics_process(_delta):
	pass


func _on_spawn_enemigo_timeout():
	_enemigo()
	enemigos -= 1
	if enemigos <= 0:
		$Spawn_Enemigo.stop()


func _enemigo():
	var pos = $Path2D
	var enemy = enemigo1.instantiate()
	enemy.global_position = Vector2(pos.global_position.x, pos.global_position.y)
	get_node("Path2D").add_child(enemy)


func _on_ready():
	Global.node_creation_paren = self


func _on_tree_exited():
	Global.node_creation_paren = null
