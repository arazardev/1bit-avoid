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
var player_points = 0
var game_over = false
var win = false
var game_started = false

signal points_scored(points)
signal game_win

func _ready() -> void:
	meteor_scene = preload("res://scenes/meteor.tscn")
	reference_rect_node = get_node("GeneralUI/ReferenceRect")
	player_node = get_node("Player")
	meteor_node_parent = get_node("Meteors")
	ui_hearts = get_node("PlayerUI/Hearts")
	ui_score = get_node("GeneralUI/Score")
	
	
	min_spawn = reference_rect_node.position.x
	max_spawn = reference_rect_node.size.x + reference_rect_node.position.x
	
	reference_rect_node.frame_initiated.connect(player_node._on_frame_initiated)
	player_node.damage_taken.connect(ui_hearts._on_player_takes_damage)
	player_node.player_died.connect(_on_end_game)
	points_scored.connect(ui_score._on_update_score)
	

func _process(delta: float) -> void:
	#if !game_started:
		#return
	if game_over:
		return
	if win:
		return
	check_win_condition()
	spawn_coldown_timer_count += delta
	#print(spawn_coldown_timer_count," - ",spawn_coldown)ds
	if spawn_coldown_timer_count > spawn_coldown_timer:
		spawn_coldown_timer_count = 0
		spawn_coldown -= spawn_coldown_decrease
	points_per_second_coldown += delta
	if points_per_second_coldown > 1:
		player_points += points_per_second
		points_scored.emit(player_points)
		points_per_second_coldown = 0
	if next_spawn == 0:
		var rand_x_pos = randf_range(min_spawn+spawn_outline,max_spawn-spawn_outline)
		spawn_meteor(Vector2(rand_x_pos,0))
	next_spawn += delta
	if next_spawn >= spawn_coldown:
		next_spawn = 0
	
func spawn_meteor(pos:Vector2):
	if meteor_node_parent != null:
		var meteor_instance = meteor_scene.instantiate()
		meteor_instance.position = pos
		meteor_instance.speed = randf_range(100,300)
		meteor_node_parent.add_child(meteor_instance)

func _on_meteor_collision(body:CollisionObject2D):
	if body.name == "Player":
		player_node._on_get_damage()
		

func check_win_condition():
	if spawn_coldown < 0.5:
		game_win.emit()
		_on_win_game()


func _on_end_game():
	var game_over_label = get_node("GeneralUI/GameOver")
	game_over_label.visible = true
	game_over = true
	meteor_node_parent.queue_free()

func _on_win_game():
	win = true
	var ui_win = get_node("GeneralUI/Win")
	ui_win.visible = true

func _on_start_game():
	var main_menu = get_node("MainMenu")
	main_menu.visible = false
	game_started = true
