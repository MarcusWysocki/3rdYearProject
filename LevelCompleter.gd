#Stairs.gd
extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print("Stop standing on me!")
			#get_tree().change_scene("TutorialLevel.tscn")