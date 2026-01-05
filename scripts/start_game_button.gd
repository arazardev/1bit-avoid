extends Button

signal game_started

func _on_pressed() -> void:
	game_started.emit()
	
