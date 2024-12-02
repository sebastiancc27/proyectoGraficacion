extends Node2D

var torre_1 = preload("res://Escenas/torre_1.tscn")
var torre_2 = preload("res://Escenas/torre_2.tscn")
var torre_3 = preload("res://Escenas/torre_3.tscn")

const precio_cannon = 200
const precio_mg = 150
const precio_missile = 400

func _ready():
	$Opciones.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("click_d"):
		$Opciones.visible = false

func _on_seleccionar_torre_pressed():
	$Opciones.visible = true


func _on_cannon_pressed():
	if precio_cannon <= Global.cash:
		var instance = torre_1.instantiate()
		add_child(instance)
		Global.cash -= precio_cannon
		$Opciones.visible = false


func _on_mg_pressed():
	if precio_mg <= Global.cash:
		var instance = torre_2.instantiate()
		add_child(instance)
		Global.cash -= precio_mg
		$Opciones.visible = false


func _on_missile_pressed():
	if precio_missile <= Global.cash:
		var instance = torre_3.instantiate()
		add_child(instance)
		Global.cash -= precio_missile
		$Opciones.visible = false
