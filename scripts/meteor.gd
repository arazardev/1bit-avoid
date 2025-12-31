extends Area2D

@export var speed = 100
#signal collisioned(body)
var animation = preload("res://scenes/explotion.tscn")

var sprite_1 = preload("res://assets/meteor_1.png")
var sprite_2 = preload("res://assets/meteor_2.png")
var sprite_3 = preload("res://assets/meteor_3.png")

var meteor_sprites =  [sprite_1,sprite_2,sprite_3]

func _ready() -> void:
	var sprite: Sprite2D = get_node("Sprite2D")
	sprite.texture = meteor_sprites[randi()%3]
	sprite.rotation = deg_to_rad(randi()%4*90)
	#var rand_degree = randi()%5 * 90
	#sprite.rotation = rand_degree

func _process(delta:float) -> void:
	position.y += speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	area_or_body_trigger(body)

func _on_area_entered(area: Area2D) -> void:
	area_or_body_trigger(area)

func area_or_body_trigger(whatever):
	var parent = get_parent().get_parent()
	parent._on_meteor_collision(whatever)
	var explotions = parent.get_node("Explotions")
	var explotion_instance = animation.instantiate()
	explotion_instance.position = position
	explotions.add_child(explotion_instance)
	queue_free()
