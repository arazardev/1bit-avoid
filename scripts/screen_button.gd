extends Button
class_name NewScreenButton

@export var new_screen_view: PackedScene


func _on_pressed() -> void:
	print("Hey")
	var screen_parent: Node = get_tree().root
	var screen_instance: Node = new_screen_view.instantiate()
	screen_parent.add_child(screen_instance)
