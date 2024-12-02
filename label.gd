extends Label

func _process(_delta):
	self.text = str("Sig. Oleada: ", $next_wave.time_left)
	
