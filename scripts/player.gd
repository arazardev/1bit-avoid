extends StaticBody2D

@export var speed = 25
@export var lives = 3

signal damage_taken
signal player_died 

var bullet_scene = preload("res://scenes/bullet.tscn")
var frame_size
var frame_position 
var collision_shape 
var collision_shape_size
func _ready():
	#frame_size = get_viewport_rect().size
	collision_shape = get_node("CollisionShape2D")
	collision_shape_size = collision_shape.shape.get_rect().size

func _on_frame_initiated(size,pos):
	frame_size = size
	frame_position = pos

func _process(delta: float) -> void:
	var velocity = get_velocity_from_user_input()
	get_input_for_shoot()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta 
	var min_pos = frame_position + (collision_shape_size / 2)
	var max_pos = frame_size+frame_position -  (collision_shape_size / 2)
	position = position.clamp(min_pos, max_pos)

func get_input_for_shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet_scene.instantiate()
		add_child(bullet_instance)
		


func get_velocity_from_user_input():
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	return velocity

func _on_get_damage():
	damage_taken.emit()
	lives -= 1
	if lives == 0:
		player_died.emit()
		queue_free()
	
