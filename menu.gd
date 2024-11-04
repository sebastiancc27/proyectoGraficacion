extends Control




func _on_button_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Mapa.tscn")


func _on_button_creditos_pressed() -> void:
	pass # Replace with function body.	


func _on_button_salir_pressed() -> void:
	get_tree().quit()
