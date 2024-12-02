extends Control

@onready var musica = $MusicaFondo

func _ready():
	musica.stream = preload("res://musicaFondo.mp3")
	musica.play()


func _on_button_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Mapa.tscn")
	musica.stop()


func _on_button_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Creditos.tscn")


func _on_button_salir_pressed() -> void:
	get_tree().quit()
