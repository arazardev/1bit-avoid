extends Node2D

@export var speed: float = 100
signal picked_up(area:Area2D)

func _ready() -> void:
	$AnimatedSprite2D.play()
	
func _process(delta: float) -> void:
	position.y += speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	picked_up.emit(area)
	if area.is_in_group("player"):
		get_tree().call_group("player","collect_coin")
		queue_free()
