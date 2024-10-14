extends Label


func load_game():
	# Verificar si el archivo existe antes de intentar abrirlo
	if FileAccess.file_exists("C:/Users/Hp/OneDrive/Escritorio/7Semestre/Graficación/Proyecto/juego2/savegame.txt"):	
		var file = FileAccess.open("C:/Users/Hp/OneDrive/Escritorio/7Semestre/Graficación/Proyecto/juego2/savegame.txt", FileAccess.READ)
		var number = file.get_line()
		text = "HighScore: " +str(number)
		file.close()
	else:
		print("Error: archivo no encontrado")
		
	
# Called when the node enters the scene tree for the first time.
func _ready() :
	load_game()


# Called evfery frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.score > Global.highscore:
		Global.highscore = Global.score
