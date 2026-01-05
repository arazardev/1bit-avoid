extends Node2D

@export var spawn_coldown = 2
var spawn_coldown_decrease = 0.2
var spawn_coldown_timer = 10
var spawn_coldown_timer_count = 0
var next_spawn = 0
var player_node
var ui_score
var reference_rect_node
var meteor_scene: Resource
var min_spawn = 0
var max_spawn = 0
var meteor_node_parent
var ui_hearts
var spawn_outline = 50
var points_per_second = 10
var points_per_second_coldown = 0
var game_over = false
var win = false
var game_started = false
var highscore_register_view
signal points_scored(points)
signal game_win

func _ready() -> void:
	highscore_register_view = load("res://scenes/highscore_register.tscn")

	points_scored.emit(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	meteor_scene = preload("res://scenes/meteor.tscn")
	reference_rect_node = get_node("PlayerUI/ReferenceRect")
	player_node = get_node("Player")
	meteor_node_parent = get_node("Meteors")
	ui_hearts = get_node("PlayerUI/Hearts")
	ui_score = get_node("../GeneralUI/Score")
	
	
	
	min_spawn = reference_rect_node.global_position.x
	max_spawn = reference_rect_node.size.x + reference_rect_node.global_position.x
	
	reference_rect_node.frame_initiated.connect(player_node._on_frame_initiated)
	player_node.damage_taken.connect(ui_hearts._on_player_takes_damage)
	player_node.player_died.connect(_on_end_game)
	points_scored.connect(ui_score._on_update_score)
	player_node.points_scored.connect(ui_score._on_update_score)
	

func _process(delta: float) -> void:
	#if !game_started:
		#return
	if game_over:
		return
	#check_win_condition()
	if win:
		return
	spawn_meteor(delta)
	
func spawn_meteor(delta:float) -> void:
	spawn_coldown_timer_count += delta
	if spawn_coldown_timer_count > spawn_coldown_timer:
		spawn_coldown_timer_count = 0
		spawn_coldown -= spawn_coldown_decrease
	points_per_second_coldown += delta
	if points_per_second_coldown > 1:
		points_scored.emit(points_per_second)
		points_per_second_coldown = 0
	if next_spawn == 0:
		var rand_x_pos: float = randf_range(min_spawn+spawn_outline,max_spawn-spawn_outline)
		var meteor_instance: Area2D = meteor_scene.instantiate()
		meteor_instance.position = Vector2(rand_x_pos,0)
		meteor_instance.speed = randf_range(100,300)
		meteor_node_parent.add_child(meteor_instance)
	next_spawn += delta
	if next_spawn >= spawn_coldown:
		next_spawn = 0

func _on_meteor_collision(body:CollisionObject2D) -> void:
	if body.name == "Player":
		player_node._on_get_damage()
		

func check_win_condition() -> void:
	if spawn_coldown < 1.8:
		game_win.emit()
		_on_win_game()


func _on_end_game() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var game_over_label:Label = get_node("../GeneralUI/GameOver")
	var root:Node = get_tree().current_scene
	game_over_label.visible = true
	game_over = true
	meteor_node_parent.queue_free()
	var game_over_sound: AudioStreamPlayer = get_node("../Sounds/GameOver")
	game_over_sound.play()
	if root.validate_if_enters_to_highscore(ui_score.score):
		var hrv_instance:Node = highscore_register_view.instantiate()
		hrv_instance.score = ui_score.score
		root.add_child(hrv_instance)
	queue_free()

func _on_restart_game() -> void:
	points_scored.emit(0)

func _on_win_game()-> void:
	var game_win_sound: AudioStreamPlayer = get_node("../Sounds/Win")
	game_win_sound.play()
	win = true
	var ui_win:Node = get_node("../GeneralUI/Win")
	ui_win.visible = true

func _on_start_game()-> void:
	var main_menu:Node = get_node("MainMenu")
	main_menu.visible = false
	game_started = true
