extends ReferenceRect


signal frame_initiated(size,pos)

func _ready() -> void:
	call_deferred("_frame_initiated")
	#var cover_instance_top = ColorRect.new()
	#var cover_instance_bottom = ColorRect.new()
	#var cover_instance_left  = ColorRect.new()
	#var cover_instance_right = ColorRect.new()
	#cover_instance_top.color = Color.RED
	#cover_instance_top.size = Vector2(size.x,100)
	#print("Cover Pos: ",cover_instance_top.position)
	#cover_instance_top.position = Vector2(0,- cover_instance_top.size.y - (border_width / 2))
	#add_child(cover_instance_top)

func _frame_initiated():
	frame_initiated.emit(size,position)
