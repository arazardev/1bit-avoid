extends Control

var score: int = 0

func _on_line_edit_text_submitted(new_text: String) -> void:
	var root: Node = get_tree().current_scene
	root.set_new_highscore(score,new_text)
	queue_free()
