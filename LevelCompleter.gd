#Stairs.gd
extends Area2D

export (String) var Destination = ""

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print("Level Complete!")
			get_tree().change_scene(Destination)