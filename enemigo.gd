extends Sprite2D

var rapidez = 120
var velocidad = Vector2()
var salud=3
@onready var sonidoDanoEnemigo : AudioStreamPlayer2D  = $SonidoEnemigo


var aturdido = false

func _process(delta):
	if Global.player !=null and aturdido==false:
		velocidad=global_position.direction_to(Global.player.global_position)
	elif aturdido:
		velocidad=lerp(velocidad,Vector2(0,0),0.3)
	global_position+=velocidad*rapidez*delta
	if salud<=0	:
		Global.score +=10
		queue_free() 


func _on_hit_box_area_entered(area: Area2D):
	if area.is_in_group("enemy_damager"):	
		sonidoDanoEnemigo.play()
		velocidad=-velocidad*1
		salud=salud-1
		aturdido=true
		$aturdido_timer.start()
		area.get_parent().queue_free()
		


func _on_aturdido_timer_timeout():
	aturdido=false
