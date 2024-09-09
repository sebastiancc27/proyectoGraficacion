extends Sprite2D

var speed = 150
var velocidad = Vector2()
var bullet = preload("res://bullet.tscn")
var can_shoot=true
@onready var sonidoBala : AudioStreamPlayer2D  = $SonidoBala
@onready var sonidoDaño : AudioStreamPlayer2D  = $SonidoDano

var is_dead = false

func _ready():
	Global.player=self
	
func _exit_tree(): 
	Global.player=null

func _process(delta):
	velocidad.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocidad.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if is_dead==false: 
		global_position += speed * velocidad * delta
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		rotation = direction.angle()

	
	if Input.is_action_pressed("shoot") and Global.node_creation_paren != null and can_shoot and is_dead==false:
		Global.instance_node(bullet, global_position, Global.node_creation_paren)
		$Reload_Speed.start()
		sonidoBala.play()
		can_shoot=false


func _on_reload_speed_timeout() -> void:
	can_shoot=true


func _on_hit_box_area_entered(area: Area2D) :
	if area.is_in_group("enemy"):
		sonidoDaño.play()
		visible=false
		Global.score=0
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		
		
