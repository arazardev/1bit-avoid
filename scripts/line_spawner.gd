extends Spawner
class_name LineSpawner

@export var line: Line2D

func _ready() -> void:
	line.visible = false

func set_random_position()->Vector2:
	var point_count : int =  line.get_point_count()
	var rand_index: int = randi_range(0,point_count-1)
	var rand_point: Vector2 = line.get_point_position(rand_index)
	spawn_position = rand_point
	return rand_point

func spawn() -> void:
	set_random_position()
	super.spawn()
	
