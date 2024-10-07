extends CanvasLayer

var paused := false

func toggle():
	if paused:
		hide()
		Engine.time_scale = 1
	else:
		show()
		Engine.time_scale = 0
	
	paused = !paused

func _on_resume_pressed():
	toggle()

func _on_back_pressed():
	toggle()
	GameManager.back_to_menu()
