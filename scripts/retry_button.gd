extends Button


signal game_restarted

func _on_pressed() -> void:
	print("Retry")
	game_restarted.emit()
	
