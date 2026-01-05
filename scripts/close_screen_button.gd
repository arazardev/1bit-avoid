extends Button



func _on_pressed() -> void:
	var parent: Node = get_parent()
	parent.queue_free()
