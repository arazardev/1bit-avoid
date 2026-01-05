extends Area2D


@export var speed = 1000
var ttl = 3
var time_counter = 0
var x_pos = 0

func _ready():
	x_pos = global_position.x

func _process(delta: float) -> void:
	var velocity = Vector2(0,-1)
	position += velocity * delta * speed
	global_position.x = x_pos
	time_counter += delta
	if time_counter > ttl:
		queue_free()
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		return
	queue_free()
	
