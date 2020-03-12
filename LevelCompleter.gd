#Stairs.gd
extends Area2D

#export (String) var port_location = "nothing"

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	#print(bodies)
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene("TutorialLevel.tscn")