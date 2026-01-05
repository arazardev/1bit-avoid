extends Button


func _on_pressed() -> void:
	get_parent().visible = false
	get_tree().current_scene.get_node("MainMenu").visible = true
