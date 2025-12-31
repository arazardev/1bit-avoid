extends Button

signal game_started

func _on_pressed() -> void:
	print("Play")
	game_started.emit()
	
