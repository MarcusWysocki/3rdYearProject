extends Control

export (String) var TestCase = "res://Level Maps/Level1.tscn"

func _input(event):
	if event is InputEventScreenTouch:
		get_tree().change_scene(TestCase)