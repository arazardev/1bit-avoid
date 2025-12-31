extends Node2D

@export var hearts_gap = 50
var initial_hearts = 3
var heart_sprite 

func _ready():
	heart_sprite = preload("res://scenes/heart_sprite.tscn")
	for i in range(initial_hearts):
		var heart_instance = heart_sprite.instantiate()
		heart_instance.position = Vector2(i*hearts_gap,0)
		add_child(heart_instance)
		
func _on_player_takes_damage():
	var last_heart = get_child(-1)
	last_heart.queue_free()

func _on_player_heals():
	var child_count = get_child_count()
	var heart_instance = heart_sprite.instantiate()
	heart_instance.position = Vector2((child_count-1)*hearts_gap,10) 
