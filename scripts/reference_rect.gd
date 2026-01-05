extends ReferenceRect


signal frame_initiated(size,pos)

func _ready() -> void:
	call_deferred("_frame_initiated")
func _frame_initiated():
	frame_initiated.emit(size,global_position)
