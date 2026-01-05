extends Control

var highscores: Array

func _ready() -> void:
	var root: Node = get_tree().current_scene
	highscores = root.highscores
	print(highscores)
	var x_position:int = 0
	var y_position:int = 0
	var score_position:int = 1
	for i:Dictionary in highscores:
		var label:Node = Label.new()
		label.position = Vector2(x_position, y_position)
		y_position += 50
		label.text = str(score_position)+" - "+str(i.score)+" - "+i.player
		score_position += 1
		$Scores.add_child(label)
	print($Scores.get_children())
