extends Node2D

@export var explotion_animation = "explotion_3"
@export var animation_expires_seconds = 2

var animation_started = false
var timeout = 0

func _ready() -> void:
	play_explotion()

func _process(delta: float) -> void:
	if animation_started:
		if timeout < animation_expires_seconds:
			timeout += animation_expires_seconds * delta
		else:
			queue_free()

func play_explotion():
	var animation_node = get_node("AnimatedSprite2D")
	animation_node.play(explotion_animation)
	animation_started = true
	
	
