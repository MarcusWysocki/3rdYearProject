extends Control

export (String) var TestCase = "Nothing"

func _on_touch_to_start_pressed():
	get_tree().change_scene(TestCase)# Replace with function body.
