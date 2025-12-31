extends Node

# Nodes
#var main_menu
var start_button
var level_1_scene 

func _ready() -> void:
	
	#Preload scenes
	#level_1_scene = preload("res://scenes/level_1.tscn").instantiate()
	
	#Get Nodes
	start_button = get_node("MainMenu/MenuButtons/Button")
	#main_menu = get_node("MainMenu")
	
	#Connect Signals
	start_button.game_started.connect(_on_start_new_game)
	

func _on_start_new_game():
	level_1_scene = preload("res://scenes/level_1.tscn").instantiate()
	var main_menu = get_node("MainMenu")
	main_menu.visible = false
	add_child(level_1_scene)
