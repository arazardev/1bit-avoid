extends Node2D
class_name Spawner

@export var object_to_spawn: PackedScene
@export var spawn_parent: Node
@export var spawn_position: Vector2 = Vector2.ZERO
@export var use_timer:bool = false
@export var coldown:float = 1
@export var counter: float = 0
#@export var spawn_area: Shape2D
#@export var spawn_poin: Array[Marker2D]
#@export var x_min_pos = 0
#@export var x_max_pos = 0
#@export var y_min_pos = 0
#@export var y_max_pos = 0
#@export var random_position_every_time = false

func _process(delta:float) -> void:
	if use_timer:
		counter += delta
		if counter >= coldown:
			#if random_position_every_time:
				#set_random_position()
			counter = 0
			spawn()

func spawn() -> void:
	var instance: Node = object_to_spawn.instantiate()
	instance.position = spawn_position
	spawn_parent.add_child(instance)

#func set_random_position()->Vector2:
	#var x_position = randf_range(x_min_pos,x_max_pos)
	#var y_position = randf_range(y_min_pos,y_max_pos)
	#x_spawn_position = x_position
	#y_spawn_position = y_position
	#return Vector2(x_position,y_position)
