extends Label

var score : int = 0

func _on_update_score(points:int) -> void:
	score += points
	text = str(score)
