extends Area2D

@export var speed:int = 25
@export var lives:int = 3

signal damage_taken
signal player_died
signal points_scored(points:int)

var points_per_coin:int = 100
var bullet_scene : Resource = preload("res://scenes/bullet.tscn")
var frame_size: Vector2
var frame_position : Vector2
var collision_shape : Node
var collision_shape_size : Vector2

func _ready() -> void:
	collision_shape = get_node("CollisionShape2D")
	collision_shape_size = collision_shape.shape.get_rect().size

func _on_frame_initiated(size:Vector2,pos:Vector2) -> void:
	frame_size = size
	frame_position  = pos

func collect_coin()->void:
	$Sounds/PickupCoin.play()
	points_scored.emit(points_per_coin)
	
func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	var min_pos: Vector2 = frame_position + (collision_shape_size / 2)
	var max_pos: Vector2  = frame_size + frame_position -  (collision_shape_size / 2)
	position = position.clamp(min_pos, max_pos)

func _on_get_damage() -> void:
	damage_taken.emit()
	$Sounds/AudioDamage.play()
	lives -= 1
	if lives == 0:
		player_died.emit()
		queue_free()
	
