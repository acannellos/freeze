extends Control

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if get_tree().paused and Input.is_action_just_pressed("quit"):
		get_tree().quit()
