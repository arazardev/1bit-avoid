extends Node

# Nodes
#var main_menu
var start_button: Node
var level_1_scene : Node
var restart_button : Node
var game_over_ui: Node
var score_ui: Label
var win_ui: Label

var highscores: Array
var savegame_file:String = "user://savegame.save"

func _ready() -> void:
	load_game()
	#Preload scenes
	#level_1_scene = preload("res://scenes/level_1.tscn").instantiate()
	
	#Get Nodes
	start_button = get_node("MainMenu/MenuButtons/StartGameButton")
	restart_button = get_node("GeneralUI/GameOver/RetryButton")
	game_over_ui = get_node("GeneralUI/GameOver")
	score_ui = get_node("GeneralUI/Score")
	win_ui = get_node("GeneralUI/Win")
	
	#main_menu = get_node("MainMenu")
	
	#Connect Signals
	start_button.game_started.connect(_on_start_new_game)
	restart_button.game_restarted.connect(_on_start_new_game)
	

func _on_start_new_game() -> void:
	$Sounds/GameStart.play()
	game_over_ui.visible = false
	if get_node("Game") != null:
		var game:Node2D = get_node("Game")
		game.free()
	level_1_scene = preload("res://scenes/level_1.tscn").instantiate()
	#level_1_scene._on_restart_game()
	var main_menu:Node = get_node("MainMenu")
	var general_ui:Node = get_node("GeneralUI")
	score_ui.score = 0
	score_ui._on_update_score(0)
	win_ui.visible = false
	general_ui.visible = true
	main_menu.visible = false
	add_child(level_1_scene)

	
func set_new_highscore(score:int,player:String) -> void:
	var score_position: int = 0
	for i in highscores:
		if score > i.score:
			break
		else:
			score_position += 1
	highscores.insert(score_position,{
		"score": score, 
		"player": player
	})
	if highscores.size() > 10:
		highscores = highscores.slice(0,10)
	save_game()

func validate_if_enters_to_highscore(score:int) -> bool:
	if highscores.size() < 10:
		return true
	for i:Dictionary in highscores:
		if score > i.score:
			return true
	return false

func save_game() -> void:
	var save_file: FileAccess = FileAccess.open(savegame_file, FileAccess.WRITE)
	var json_string: String = JSON.stringify(highscores)
	print("Saving string:",json_string)
	save_file.store_line(json_string)


func load_game() -> void:
	if not FileAccess.file_exists(savegame_file):
		print("Error! We don't have a save to load.")
		return
	var save_file:FileAccess = FileAccess.open(savegame_file, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string:String = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json:JSON = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result: Error = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		print("Loaded Data:", json.data)
		highscores = json.data
		
