extends CanvasLayer

func _on_retry_pressed() -> void:
	print("Retry button pressed")
	Engine.time_scale = 1
	GameManager.start_game()

func _on_main_menu_pressed() -> void:
	print("Main menu button pressed")
	Engine.time_scale = 1
	GameManager.back_to_menu()

func _on_quit_pressed() -> void:
	print("Quit button pressed")
	Engine.time_scale = 1
	GameManager.quit_game()
